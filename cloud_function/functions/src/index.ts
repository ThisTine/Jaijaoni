import { initializeApp } from "firebase-admin/app";
import { getFirestore } from "firebase-admin/firestore";
import * as functions from "firebase-functions";
import { log } from "firebase-functions/logger";
import { messaging,firestore } from "firebase-admin";
import { MulticastMessage } from "firebase-admin/lib/messaging/messaging-api";

initializeApp();

const db = getFirestore();

// // Start writing functions
// // https://firebase.google.com/docs/functions/typescript

interface userData {
  charts?: { monthLabel: string; lendTotal?: number; borrowTotal?: number }[];
}

export const recalculateDebt = functions.firestore
  .document("Borrowers/{borrowersId}")
  .onCreate(async (snapshot) => {
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
    const firestore = db;
    const userCollection = firestore.collection("Users");
    const createdDate = snapshot.createTime.toDate();
    const monthLabel = `${
      MONTHS[createdDate.getMonth()]
    }, ${createdDate.getFullYear()}`;
    const borrowerData = snapshot.data() as {
      borrowId: string;
      lenderUserId: string;
      borrowerUserId: string;
      debtTotal: number;
    };
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
              lendTotal: item.lendTotal || 0 + borrowerData.debtTotal || 0,
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
                  item.borrowTotal || 0 + borrowerData.debtTotal || 0,
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
      await userCollection
        .doc(borrowerData.borrowerUserId)
        .set({ ...borrowerDoc.data(), charts: updatedBorrowerMonthData });
    } catch (err) {
      log(err);
    }
  });

export const notifyDebtors = functions.firestore.document("Debts/{debtId}").onCreate( async (snapshot)=>{
  try{
    const data = snapshot.data() as {borrowersUserId?: string[],due?: firestore.Timestamp,debtName?: string};
    const users = await db.collection("Users").where(firestore.FieldPath.documentId(), "in", [...data?.borrowersUserId || []] ).get();
    let messages:string[] = [];
    for(const usr of users.docs){
      for(const token of (usr.data() as {tokens?:string[]}).tokens || []){
        messages = [...messages,token];
      }
    }
    const multicastMsg: MulticastMessage = {
      data: {
        content: `${data.debtName} has been created.`
      },
      tokens: messages
      
    }
    await messaging().sendEachForMulticast(multicastMsg)
  }catch(err){
    log(err)
  }


});

export const cleanupDebt = functions.firestore.document("Debts/{debtId}").onDelete( async (snapshot)=>{
  try {
    const debtId = snapshot.id;
    const docs = await db.collection("Borrowers").where("debtId","==",debtId).get()
    const batch = db.batch()
    for(const doc of docs.docs){
      batch.delete(db.collection("Borrowers").doc(doc.id))
    }
    await batch.commit()
  } catch (error) {
    log(error);
  }
})