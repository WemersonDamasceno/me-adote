import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../../../../core/errors/exceptions.dart';
import '../models/user_model.dart';

abstract class LoginDatasource {
  Future<String?> login(String email, String password);

  Future<String?> register(String email, String password, String name);

  Future<bool> saveUser(UserModel user);

  Future<UserModel> getUser(String uid);
}

class LoginDatasourceImpl implements LoginDatasource {
  FirebaseFirestore instanceFB = FirebaseFirestore.instance;

  @override
  Future<String?> login(String email, String password) async {
    try {
      final token = await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      return token.user!.uid;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found' || e.code == 'invalid-email') {
        throw const UserNotFoundException();
      } else if (e.code == 'wrong-password' || e.code == 'invalid-credential') {
        throw const WrongPasswordException();
      }
      throw const ServerException();
    }
  }

  @override
  Future<String?> register(String email, String password, String name) async {
    try {
      final credential =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      await credential.user!.updateDisplayName(name);

      return credential.user!.uid;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        throw const PasswordIsTooWeakException();
      } else if (e.code == 'email-already-in-use') {
        throw const EmailAlreadyInUseException();
      }
    } catch (e) {
      throw const ServerException();
    }
    return null;
  }

  @override
  Future<bool> saveUser(UserModel user) async {
    try {
      await instanceFB.collection('users').doc(user.uid).set(user.toMap());
      return true;
    } on FirebaseException {
      throw const ServerException();
    } catch (e) {
      throw const ServerException();
    }
  }

  @override
  Future<UserModel> getUser(String uid) async {
    try {
      final user = await instanceFB.collection('users').doc(uid).get();
      return UserModel.fromMap(user.id, user.data()!);
    } on FirebaseException {
      throw const ServerException();
    } catch (e) {
      throw const ServerException();
    }
  }
}
