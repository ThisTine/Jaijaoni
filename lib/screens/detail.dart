//Phon
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
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
    return debtStream.when(
        data: (data) {
          if (data.userId == userId) {
            return DetailCreator(
              debt: data,
            );
          }
          return DetailCustomer(
            debt: data,
          );
        },
        error: (error, stack) {
          // print(error.toString());
          // showSnackBar(context,
          //     "Couldn't find debt detail or this debt doesn't belong to you");
          context.go("/");
          return const LoadingScreen();
        },
        loading: () => const LoadingScreen());
  }
}
