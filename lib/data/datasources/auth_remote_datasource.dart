import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/user_model.dart';

abstract class AuthRemoteDataSource {
  Future<UserModel> Login(String email, String password);
  Future<UserModel> register(String name, String email, String password,String role);
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
  Future<UserModel> Login(String email, String password) async {
    final credential = await firebaseAuth.signInWithEmailAndPassword(
      email: email,
      password: password,
    );

    final userDoc = await firestore
        .collection('users')
        .doc(credential.user!.uid)
        .get();

    return UserModel.fromMap(userDoc.data()!, userDoc.id);
  }

Future<UserModel> register(String name, String email, String password, String role) async {
  try {
    final credential = await firebaseAuth.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );

    final user = UserModel(
      id: credential.user!.uid,
      name: name,
      email: email,
      role: role,
    );

    await firestore.collection('users').doc(user.id).set(user.toMap());

    return user;
  } on FirebaseAuthException catch (e) {
    if (e.code == 'email-already-in-use') {
      throw Exception("This email is already registered.");
    } else {
      throw Exception(e.message ?? "Registration failed.");
    }
  }
}



  @override
  Future<UserModel> getCurrentUser() async {
    final currentUser = firebaseAuth.currentUser;
    if (currentUser == null) throw Exception("No user logged in");

    final userDoc = await firestore
        .collection('users')
        .doc(currentUser.uid)
        .get();

    return UserModel.fromMap(userDoc.data()!, userDoc.id);
  }

  @override
  Future<void> signOut() async {
    await firebaseAuth.signOut();
  }
}
