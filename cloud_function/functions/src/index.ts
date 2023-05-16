import { initializeApp } from "firebase-admin/app";
import { getFirestore } from "firebase-admin/firestore";
import * as functions from "firebase-functions";
import { log } from "firebase-functions/logger";
import { messaging, firestore } from "firebase-admin";
import { MulticastMessage } from "firebase-admin/lib/messaging/messaging-api";

initializeApp();

const db = getFirestore();

// // Start writing functions
// // https://firebase.google.com/docs/functions/typescript

interface userData {
  tokens?: string[];
  charts?: { monthLabel: string; lendTotal?: number; borrowTotal?: number }[];
}

interface borrowersType {
  borrowId: string;
  lenderUserId: string;
  borrowerUserId: string;
  debtTotal: number;
}

interface debtType {
  userId: string;
  transactions: { amount: number; username: string; transactionId: string }[];
}

const MONTHS = [
  "January",
  "February",
  "March",
  "April",
  "May",
  "June",
  "July",
  "August",
  "September",
  "October",
  "November",
  "December",
];

export const recalculateDebt = functions.firestore
  .document("Borrowers/{borrowersId}")
  .onCreate(async (snapshot) => {
    const firestore = db;
    const userCollection = firestore.collection("Users");
    const createdDate = snapshot.createTime.toDate();
    const monthLabel = `${
      MONTHS[createdDate.getMonth()]
    }, ${createdDate.getFullYear()}`;
    const borrowerData = snapshot.data() as borrowersType;
    try {
      const lenderDoc = await userCollection
        .doc(borrowerData.lenderUserId)
        .get();
      const borrowerDoc = await userCollection
        .doc(borrowerData.borrowerUserId)
        .get();
      const lenderDataMonth = (lenderDoc.data() as userData).charts || [];
      const borrowerDataMonth = (borrowerDoc.data() as userData).charts || [];

      let updatedLenderMonthData = lenderDataMonth;
      let updatedBorrowerMonthData = borrowerDataMonth;

      if (lenderDataMonth.map((item) => item.monthLabel).includes(monthLabel)) {
        updatedLenderMonthData = updatedLenderMonthData.map((item) =>
          item.monthLabel == monthLabel
            ? {
              ...item,
              lendTotal:
                  (item.lendTotal || 0) + (borrowerData.debtTotal || 0),
            }
            : item
        );
      } else {
        updatedLenderMonthData = [
          ...updatedLenderMonthData,
          {
            borrowTotal: 0,
            lendTotal: borrowerData.debtTotal || 0,
            monthLabel: monthLabel,
          },
        ];
      }

      if (
        borrowerDataMonth.map((item) => item.monthLabel).includes(monthLabel)
      ) {
        updatedBorrowerMonthData = updatedBorrowerMonthData.map((item) =>
          item.monthLabel == monthLabel
            ? {
              ...item,
              borrowTotal:
                  (item.borrowTotal || 0) + (borrowerData.debtTotal || 0),
            }
            : item
        );
      } else {
        updatedBorrowerMonthData = [
          ...updatedBorrowerMonthData,
          {
            lendTotal: 0,
            borrowTotal: borrowerData.debtTotal || 0,
            monthLabel: monthLabel,
          },
        ];
      }
      await userCollection
        .doc(borrowerData.lenderUserId)
        .set({ ...lenderDoc.data(), charts: updatedLenderMonthData });
      log("updating...", borrowerData.lenderUserId, updatedLenderMonthData);
      await userCollection
        .doc(borrowerData.borrowerUserId)
        .set({ ...borrowerDoc.data(), charts: updatedBorrowerMonthData });
      log("updating...", borrowerData.borrowerUserId, updatedBorrowerMonthData);
    } catch (err) {
      log(err);
    }
  });

export const notifyDebtors = functions.firestore
  .document("Debts/{debtId}")
  .onCreate(async (snapshot) => {
    try {
      const data = snapshot.data() as {
        borrowersUserId?: string[];
        due?: firestore.Timestamp;
        debtName?: string;
      };
      const users = await db
        .collection("Users")
        .where(firestore.FieldPath.documentId(), "in", [
          ...(data?.borrowersUserId || []),
        ])
        .get();
      let messages: string[] = [];
      for (const usr of users.docs) {
        for (const token of (usr.data() as { tokens?: string[] }).tokens ||
          []) {
          messages = [...messages, token];
        }
      }
      const multicastMsg: MulticastMessage = {
        notification: {
          title: `${data.debtName} has been created.`,
          body: `Please make a payment by ${data.due?.toDate().toISOString()}`,
        },
        data: {
          content: `${data.debtName} has been created.`,
          screen: `detail/${snapshot.id}`,
        },
        tokens: messages,
      };
      log("Sending to debt");
      await messaging().sendEachForMulticast(multicastMsg);
      log("Sending", multicastMsg);
    } catch (err) {
      log(err);
    }
  });

export const cleanupDebt = functions.firestore
  .document("Debts/{debtId}")
  .onDelete(async (snapshot) => {
    try {
      const firestore = db;
      const userCollection = firestore.collection("Users");
      const deletingDebt = snapshot.data() as { userId: string };

      const createdDate = snapshot.createTime.toDate();
      const monthLabel = `${
        MONTHS[createdDate.getMonth()]
      }, ${createdDate.getFullYear()}`;

      const debtId = snapshot.id;
      const docs = await db
        .collection("Borrowers")
        .where("debtId", "==", debtId)
        .get();
      const batch = db.batch();

      const lenderQuery = await userCollection.doc(deletingDebt.userId).get();

      const lenderDoc = lenderQuery.data() as userData;

      const lenderChart: {
        monthLabel: string;
        lendTotal?: number;
        borrowTotal?: number;
      } =
        (lenderDoc.charts || []).filter((e) => e.monthLabel === monthLabel)
          .length == 1
          ? (lenderDoc.charts || []).filter(
            (e) => e.monthLabel === monthLabel
          )[0]
          : { monthLabel: monthLabel, borrowTotal: 0, lendTotal: 0 };

      for (const doc of docs.docs) {
        const borrowerData = doc.data() as {
          borrowId: string;
          lenderUserId: string;
          borrowerUserId: string;
          debtTotal: number;
        };
        const borrowerQuery = await await userCollection
          .doc(borrowerData.borrowerUserId)
          .get();

        const borrowerDoc = borrowerQuery.data() as userData;
        lenderChart.lendTotal = lenderChart.lendTotal
          ? lenderChart.lendTotal - borrowerData.debtTotal
          : 0;

        const borrowerMonthLabelFilteredChart = (
          borrowerDoc.charts || []
        ).filter((e) => e.monthLabel === monthLabel);

        const borrowerChart =
          borrowerMonthLabelFilteredChart.length == 1
            ? {
              ...borrowerMonthLabelFilteredChart[0],
              borrowTotal:
                  (borrowerMonthLabelFilteredChart[0].borrowTotal || 0) -
                  borrowerData.debtTotal,
            }
            : { monthLabel: monthLabel, borrowTotal: 0, lendTotal: 0 };

        batch.update(userCollection.doc(borrowerQuery.id), {
          charts: [
            ...(borrowerDoc.charts || []).filter(
              (e) => e.monthLabel != monthLabel
            ),
            borrowerChart,
          ],
        });

        batch.delete(db.collection("Borrowers").doc(doc.id));
      }
      batch.update(userCollection.doc(lenderQuery.id), {
        charts: [
          ...(lenderDoc.charts || []).filter((e) => e.monthLabel != monthLabel),
          lenderChart,
        ],
      });

      await batch.commit();
    } catch (error) {
      log(error);
    }
  });

export const notifyTransaction = functions.firestore
  .document("Debts/{debtId}")
  .onUpdate(async (change) => {
    try {
      const beforeSnapShot = change.before.data() as debtType;
      const afterSnapShot = change.after.data() as debtType;

      if (
        beforeSnapShot.transactions.length !== afterSnapShot.transactions.length
      ) {
        const filteredTransactions = afterSnapShot.transactions.filter((i) =>
          beforeSnapShot.transactions
            .map((e) => e.transactionId)
            .includes(i.transactionId)
        );

        const user = (
          await db.collection("Users").doc(afterSnapShot.userId).get()
        ).data() as userData;
        const tokens = user.tokens || [];

        const multicastMsg: MulticastMessage = {
          notification: {
            title: `${filteredTransactions
              .map((e) => e.username)
              .toLocaleString()} sent you a payment.`,
            body: `${filteredTransactions
              .map((e) => e.amount)
              .toLocaleString()} is waiting for you to review.`,
          },
          data: {
            content: "Payment sent",
            screen: `detail/${change.before.id}`,
          },
          tokens: tokens,
        };
        await messaging().sendEachForMulticast(multicastMsg);
      }
    } catch (err) {
      log(err);
    }
  });

export const notifyFriendRequest = functions.firestore.document("FriendsReqs/{reqId}").onCreate(async (snapshot)=>{
  try{
    const data = snapshot.data() as {anotherUsername:string,username:string}
    const users = (await db.collection("Users").where("username","==",data.anotherUsername).get()).docs as userData[]
    const tokens = users[0].tokens || []
    const multicastMsg: MulticastMessage = {
      notification: {
        title: `${data.username} sent you a firend request.`,
        body: `Please review a friend request by ${data.username}`,
      },
      data: {
        content: "friend request sent",
        screen: "/friends",
      },
      tokens: tokens,
    };
    await messaging().sendEachForMulticast(multicastMsg);
  }catch(err){
    log(err);
  }
})