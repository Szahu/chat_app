import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';
import 'package:chat_app/services/dataBase_service.dart';

class User {
  User({this.uid, this.userData});
  final String uid;
  final UserData userData;
}

class AuthService {
  static final AuthService _instance = AuthService._internal();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  User loggedUser;
  AuthService._internal();
  String _currentUserUid;

  factory AuthService() {
    return _instance;
  }

  Stream<User> get getUser {
    return _auth.onAuthStateChanged.map(_userFromFirebaseUser);
  }

  User _userFromFirebaseUser(FirebaseUser user) {
    return user != null
        ? User(
            uid: user.uid,
            userData: UserData(
                name: 'new Name', profile_picture: 'url', uid: user.uid))
        : null;
  }

  Future updateCurrentUserUid() async {
    final user = await FirebaseAuth.instance.currentUser();
    _currentUserUid = user.uid.toString();
    return null;
  }

  String getCurrentUserUid() {
    updateCurrentUserUid();
    return _currentUserUid;
  }

  int _handleSignInErrors(String errorCode) {
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

  int _handleRegisterErrors(String errorCode) {
    switch (errorCode) {
      case 'ERROR_INVALID_EMAIL':
        {
          return 1;
        }
        break;
      case 'ERROR_WEAK_PASSWORD':
        {
          return 2;
        }
        break;
      case 'ERROR_EMAIL_ALREADY_IN_USE':
        {
          return 3;
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
      DataBaseService().createUserData(user.uid);
      return _userFromFirebaseUser(user);
    } catch (e) {
      print(e.toString());
      return _handleRegisterErrors(e.code.toString());
    }
  }

  Future signInWithEmailAndPassword(String email, String password) async {
    try {
      AuthResult result = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      FirebaseUser user = result.user;
      loggedUser = _userFromFirebaseUser(user);
      return _userFromFirebaseUser(user);
    } catch (e) {
      print(e.toString());
      return _handleSignInErrors(e.code.toString());
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

  // TODO add loging in with google

  // TODO add loging in with facebook
}
