import 'package:cs310_week5_app/services/database.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  User? _userFromAuth(User? user) {
    return user;
  }

  Stream<User?> get user {
    return _auth.authStateChanges().map(_userFromAuth);
  }

  Future signInAnon() async {
    try {
      UserCredential uc = await _auth.signInAnonymously();
      User? user = uc.user;
      await DBService(userToken: user!.uid)
          .createUserData(user.displayName ?? 'Anon User', '2021-08-09');
      return _userFromAuth(user);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'operation-not-allowed') {
        return '${e.message}';
      }
    } catch (e) {
      return 'Unknown error: ${e.toString()}';
    }
  }

  Future signIn(String mail, String pass) async {
    try {
      UserCredential uc =
          await _auth.signInWithEmailAndPassword(email: mail, password: pass);
      User? user = uc.user;
      await DBService(userToken: user!.uid)
          .createUserData(user.displayName ?? 'No Name', '2021-08-09');
      return _userFromAuth(user);
    } on FirebaseAuthException catch (e) {
      print(e.toString());

      if (e.code == 'invalid-email') {
        return '${e.message}';
      } else if (e.code == 'user-disabled') {
        return '${e.message}';
      } else if (e.code == 'wrong-password') {
        return '${e.message}';
      } else if (e.code == 'user-not-found') {
        return '${e.message}';
      }
      return null;
    } catch (e) {
      return 'Unknown error: ${e.toString()}';
    }
  }

  Future signUp(String mail, String pass) async {
    try {
      UserCredential uc = await _auth.createUserWithEmailAndPassword(
          email: mail, password: pass);
      User? user = uc.user;
      await DBService(userToken: user!.uid)
          .createUserData(user.displayName!, '2021-08-09');
      return _userFromAuth(user);
    } on FirebaseAuthException catch (e) {
      print(e.toString());

      if (e.code == 'email-already-in-use') {
        return '${e.message}';
      } else if (e.code == 'invalid-email') {
        return '${e.message}';
      } else if (e.code == 'operation-not-allowed') {
        return '${e.message}';
      } else if (e.code == 'weak-password') {
        return '${e.message}';
      }
    } catch (e) {
      return 'Unknown error: ${e.toString()}';
    }
  }

  Future signOut() async {
    try {
      return await _auth.signOut();
    } catch (e) {
      print(e.toString());
      return null;
    }
  }
}
