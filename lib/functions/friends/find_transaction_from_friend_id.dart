import 'package:firebase_auth/firebase_auth.dart';
import 'package:jaijaoni/functions/utils/find_user_by_id.dart';
import 'package:jaijaoni/model/debt.model.dart';
import 'package:jaijaoni/model/user.model.dart';
import 'package:jaijaoni/services/store/fire_store_service.dart';

class TransactionsWithDebtId {
  final Transactions transac;
  final String debtId;
  TransactionsWithDebtId({required this.transac, required this.debtId});
}

Future<List<TransactionsWithDebtId>> findTransactionFromFriendId(
    String friendId) async {
  try {
    // Find friend from database by using given friendId
    Users friend = await findUserById(friendId);
    // Takes logged in userId
    String userId = FirebaseAuth.instance.currentUser!.uid;
    // query debts from firebase where the logged user is the lender and the key "borrowersUserId" (array of string) has contained given friendId
    var debtQuery = await FireStoreService.collection.debts
        .where("userId", isEqualTo: userId)
        .where("borrowersUserId", arrayContains: friendId)
        .get();
    // mapped the debt that query from firestore into workable object
    List<Debts> debts =
        debtQuery.docs.map((e) => Debts.fromFireStore(e)).toList();
    // create empity list of transaction
    List<TransactionsWithDebtId> relatedTransactions = [];
    for (Debts debt in debts) {
      // add the transaction that created by friend in to the list
      relatedTransactions = [
        ...relatedTransactions,
        ...debt.transactions
            .where((friendTransaction) =>
                friendTransaction.username == friend.username)
            .map((e) => TransactionsWithDebtId(transac: e, debtId: debt.debtId))
            .toList()
      ];
    }
    // return the list
    return relatedTransactions;
  } catch (err) {
    rethrow;
  }
}
