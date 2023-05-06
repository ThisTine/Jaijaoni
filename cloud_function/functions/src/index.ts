import { initializeApp } from "firebase-admin/app";
import { getFirestore } from "firebase-admin/firestore";
import * as functions from "firebase-functions";
import { log } from "firebase-functions/logger";

initializeApp();

const db = getFirestore();

// // Start writing functions
// // https://firebase.google.com/docs/functions/typescript

interface userData {
  charts: { monthLabel: string; lendTotal: number; borrowTotal: number }[];
}

export const recalculateDebt = functions.firestore
  .document("/Borrowers/{borrowersId}")
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
    },${createdDate.getFullYear()}`;
    const borrowerData = snapshot.data() as {
      borrowId: string;
      lenderUserId: string;
      borrowerUserId: string;
      amount: number;
    };
    try {
      const lenderDoc = await userCollection
        .doc(borrowerData.lenderUserId)
        .get();
      const borrowerDoc = await userCollection
        .doc(borrowerData.borrowerUserId)
        .get();
      const lenderDataMonth = (lenderDoc.data() as userData).charts;
      const borrowerDataMonth = (borrowerDoc.data() as userData).charts;
      let updatedLenderMonthData = lenderDataMonth;
      let updatedBorrowerMonthData = borrowerDataMonth;
      if (lenderDataMonth.map((item) => item.monthLabel).includes(monthLabel)) {
        updatedLenderMonthData = updatedLenderMonthData.map((item) =>
          item.monthLabel == monthLabel
            ? { ...item, lendTotal: item.lendTotal + borrowerData.amount }
            : item
        );
      } else {
        updatedLenderMonthData = [
          ...updatedLenderMonthData,
          {
            borrowTotal: 0,
            lendTotal: borrowerData.amount,
            monthLabel: monthLabel,
          },
        ];
      }

      if (
        borrowerDataMonth.map((item) => item.monthLabel).includes(monthLabel)
      ) {
        updatedBorrowerMonthData = updatedBorrowerMonthData.map((item) =>
          item.monthLabel == monthLabel
            ? { ...item, borrowTotal: item.borrowTotal + borrowerData.amount }
            : item
        );
      } else {
        updatedBorrowerMonthData = [
          ...updatedBorrowerMonthData,
          {
            lendTotal: 0,
            borrowTotal: borrowerData.amount,
            monthLabel: monthLabel,
          },
        ];
      }
      await userCollection
        .doc(borrowerData.lenderUserId)
        .update({ charts: updatedLenderMonthData });
      await userCollection
        .doc(borrowerData.borrowerUserId)
        .update({ charts: updatedBorrowerMonthData });
    } catch (err) {
      log(err);
    }
  });
