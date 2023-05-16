//Phon
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
// import 'package:go_router/go_router.dart';
import 'package:jaijaoni/functions/home/delete_debt.dart';
import 'package:jaijaoni/providers/friends/show_snackbar.dart';
import 'package:jaijaoni/providers/home/get_debt_stream_provider.dart';
import 'package:jaijaoni/screens/detail_creator.dart';
import 'package:jaijaoni/screens/detail_customer.dart';
import 'package:jaijaoni/screens/loading.dart';

class DebtDetailScreen extends ConsumerWidget {
  final String debtId;
  const DebtDetailScreen({super.key, required this.debtId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final String userId = FirebaseAuth.instance.currentUser!.uid;
    var debtStream = ref.watch(debtStreamProvider(debtId));
    void deleteDebt() {
      deleteDebtbyId(debtId: debtId).then((value) {
        context.go("/");
      }).onError((error, stackTrace) {
        showSnackBar(context, error.toString());
      });
    }

    return debtStream.when(
        data: (data) {
          if (data.userId == userId) {
            return DetailCreator(debt: data, deleteDebt: deleteDebt);
          }
          return DetailCustomer(
            debt: data,
          );
        },
        error: (error, stack) {
          // showSnackBar(context,
          //     "Couldn't find debt detail or this debt doesn't belong to you");
          // context.go("/");
          return const LoadingScreen();
        },
        loading: () => const LoadingScreen());
  }
}
