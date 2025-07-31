import 'package:firebase_auth/firebase_auth.dart';
import '../models/user_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

abstract class AuthRemoteDataSource {
  Future<UserModel> signIn(String email, String password);
  Future<UserModel> getCurrentUser();
  Future<void> signOut();
}

class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  final FirebaseAuth firebaseAuth;
  final FirebaseFirestore firestore;

  AuthRemoteDataSourceImpl({
    required this.firebaseAuth,
    required this.firestore,
  });

  @override
  Future<UserModel> signIn(String email, String password) async {
    final credential = await firebaseAuth.signInWithEmailAndPassword(
      email: email,
      password: password,
    );

    final userDoc =
        await firestore.collection('users').doc(credential.user!.uid).get();

    return UserModel.fromMap(userDoc.data()!, userDoc.id);
  }

  @override
  Future<UserModel> getCurrentUser() async {
    final currentUser = firebaseAuth.currentUser;
    if (currentUser == null) throw Exception("No user logged in");

    final userDoc =
        await firestore.collection('users').doc(currentUser.uid).get();

    return UserModel.fromMap(userDoc.data()!, userDoc.id);
  }

  @override
  Future<void> signOut() async {
    await firebaseAuth.signOut();
  }
}
