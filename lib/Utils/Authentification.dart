import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dealtoutv2/UI/HomePage.dart';
import 'package:dealtoutv2/globalsvariable.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';

import '../main.dart';

  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  VoidCallback onSignedIn;
  VoidCallback onSignedOut;

  Future<String> SignIn(
      String email, String password, context, _scaffoldKey) async {
    try {
      User user = (await _firebaseAuth.signInWithEmailAndPassword(
          email: email, password: password))
          .user;
      showInSnackBar("Connectée.", _scaffoldKey, context);
      Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => HomePage(),
          ));
      onSignedIn();
    } catch (exception) {
      if (exception.code == "ERROR_WRONG_PASSWORD") {
        showInSnackBar("Mot de passe incorrect.", _scaffoldKey, context);
        Navigator.pop(context);
      } else if (exception.code == "ERROR_USER_NOT_FOUND") {
        showInSnackBar("Vous n'avez pas de compte.", _scaffoldKey, context);
        Navigator.pop(context);
      } else if (exception.code == "ERROR_USER_DISABLED") {
        showInSnackBar("Compte desactivé par l'admin", _scaffoldKey, context);
        Navigator.pop(context);
      } else if (exception.code == "ERROR_INVALID_EMAIL") {
        showInSnackBar("Adresse mail invalide.", _scaffoldKey, context);
        Navigator.pop(context);
      } else if (exception.code == "ERROR_TOO_MANY_REQUESTS") {
        showInSnackBar("Erreur, too many requests", _scaffoldKey, context);
        Navigator.pop(context);
      } else {
        showInSnackBar(exception.code, _scaffoldKey, context);
        Navigator.pop(context);
      }
    }
  }

  Future<String> SignUp(String email, String password, String telephone,
      String name, context, _scaffoldKey) async {
    try {
      User user = (await _firebaseAuth.createUserWithEmailAndPassword(
          email: email, password: password))
          .user;

      var data = {
        "key": user.uid.toString(),
        "email": email,
        "password": password,
        "telephone": telephone,
        "name": name,
      };

      final FirebaseFirestore _firestore = FirebaseFirestore.instance;
      await _firestore.collection('Users').doc(user.uid.toString()).set(data);

      Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => HomePage(),
          ));
      onSignedIn();

      showInSnackBar("Inscription effectuée.", _scaffoldKey, context);

      return user.uid;
    } catch (exception) {
        showInSnackBar(exception.message, _scaffoldKey, context);
        Navigator.pop(context);

    }
  }

  Future<String> getCurrentUser() async {
    User user = await _firebaseAuth.currentUser;
    return user.uid;
  }

  User users = _firebaseAuth.currentUser;

  Future<void> signOut(context) async {
    _firebaseAuth.signOut();
    users = null;
    Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => MyApp(),
        ));
    onSignedOut();
  }

  Future<void> resetmail(String email, context, _scaffoldKey) async {
    try {
      await _firebaseAuth.sendPasswordResetEmail(email: email);
      showInSnackBar("Email de restauration envoyé.", _scaffoldKey, context);
    } on PlatformException catch (exception) {
      if (exception.code == "ERROR_INVALID_EMAIL") {
        showInSnackBar(
            "Erreur, votre adresse mail est invalide.", _scaffoldKey, context);
      } else {
        showInSnackBar(exception.message, _scaffoldKey, context);
      }
    }
  }

  void showInSnackBar(String value, _scaffoldKey, context) {
    FocusScope.of(context).requestFocus(new FocusNode());
    _scaffoldKey.currentState?.removeCurrentSnackBar();
    _scaffoldKey.currentState.showSnackBar(new SnackBar(
      content: new Text(
        value,
        textAlign: TextAlign.center,
        style: TextStyle(
          color: Colors.white,
          fontSize: 16.0,
        ),
      ),
      backgroundColor: Colors.blue,
      duration: Duration(seconds: 3),
    ));
  }
