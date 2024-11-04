import 'package:firebase_auth/firebase_auth.dart';

import '../../../../core/errors/exceptions.dart';

abstract class RemoteDatasource {
  Future<String?> login(String email, String password);
  Future<String?> register(String email, String password, String name);
}

class RemoteDatasourceImpl implements RemoteDatasource {
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
}
