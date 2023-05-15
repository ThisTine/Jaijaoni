import 'package:firebase_auth/firebase_auth.dart';
import '../../model/user.model.dart';
import '../utils/find_user_by_id.dart';

Future<String> username() async {
  try {
    String userName = FirebaseAuth.instance.currentUser!.uid;
    Users user = await findUserById(userName);
    return user.name;
  } catch (err) {
    rethrow;
  }
}

Future<String> quoteprefill() async {
  try {
    String? userName = FirebaseAuth.instance.currentUser!.uid;
    Users? user = await findUserById(userName);
    if (user.quote == null) {
      return 'add quote';
    }
    return user.quote ?? '';
  } catch (err) {
    rethrow;
  }
}


//EX usecase
  // FutureBuilder<String>(
  //                 future: username(),
  //                 builder: (context, snapshot) {
  //                   if (snapshot.connectionState == ConnectionState.waiting) {
  //                     return const Text('Loading...');
  //                   }
  //                   if (snapshot.hasError) {
  //                     return Text('Error: ${snapshot.error}');
  //                   }
  //                   return Text(
  //                     ' ${snapshot.data ?? ''}',
  //                     style: TextStyle(
  //                       color: Theme.of(context).colorScheme.primary,
  //                       fontSize:
  //                           Theme.of(context).textTheme.headlineSmall!.fontSize,
  //                     ),
  //                   );
  //                 },
  //               ),