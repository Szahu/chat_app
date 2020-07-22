import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';

class User {
  User(this.uid);
  final String uid;
}

class AuthService {
  static final AuthService _instance = AuthService._internal();
  final FirebaseAuth _auth = FirebaseAuth.instance;

  AuthService._internal();

  factory AuthService() {
    return _instance;
  }

  User _userFromFirebaseUser(FirebaseUser user) {
    return user != null ? User(user.uid) : null;
  }

  int _handleErrors(String errorCode) {
    switch (errorCode) {
      case 'ERROR_INVALID_EMAIL':
        {
          return 1;
        }
        break;
      case 'ERROR_WRONG_PASSWORD':
        {
          return 2;
        }
        break;
      case 'ERROR_USER_NOT_FOUND':
        {
          return 3;
        }
        break;
      case 'ERROR_TOO_MANY_REQUESTS':
        {
          return 4;
        }
        break;
      default:
        {
          return 0;
        }
        break;
    }
  }

  Future registerWithEmailAndPassword(String email, String password) async {
    try {
      AuthResult result = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      FirebaseUser user = result.user;
      return _userFromFirebaseUser(user);
    } catch (e) {
      print(e.toString());
      return _handleErrors(e.code.toString());
    }
  }

  // TODO add error handling
  Future signInWithEmailAndPassword(String email, String password) async {
    try {
      AuthResult result = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      FirebaseUser user = result.user;
      return _userFromFirebaseUser(user);
    } catch (e) {
      print(e.toString());
      return _handleErrors(e.code.toString());
    }
  }

  // TODO add loging in with google

  // TODO add loging in with facebook
}
