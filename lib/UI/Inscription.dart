import 'package:dealtoutv2/Utils/Authentification.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../globalsvariable.dart';
import 'HomePage.dart';

class Inscription extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _Inscription();
  }
}

class _Inscription extends State<Inscription>{

  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  final FocusNode myFocusNodePassword = FocusNode();
  final FocusNode myFocusNodeEmail = FocusNode();
  final FocusNode myFocusNodeName = FocusNode();
  final FocusNode myFocusNodePhone = FocusNode();

  TextEditingController signupEmailController = new TextEditingController();
  TextEditingController signupPhoneController = new TextEditingController();
  TextEditingController signupNameController = new TextEditingController();
  TextEditingController signupPasswordController = new TextEditingController();
  TextEditingController signupConfirmPasswordController = new TextEditingController();

  bool _obscureTextSignup = true;
  bool _obscureTextSignupConfirm = true;

  final formKey = new GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: Colors.black,
      appBar: AppBar(
        leading: backButton(context),
        backgroundColor: Colors.black,
        elevation: 0.0,
      ),
      body: SingleChildScrollView(
        child: Container(
            child: Padding(
              padding: EdgeInsets.all(width(context) / 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(
                    child: Text(
                      "INSCRIPTION",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontSize: width(context) / 15,
                        color: Colors.white,
                        letterSpacing: 2.0
                      ),
                    ),
                  ),

                  SizedBox(
                      height: 15.0
                  ),

                  Container(
                    child: Form(
                      key: formKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          TextField(
                            focusNode: myFocusNodeName,
                            controller: signupNameController,
                            keyboardType: TextInputType.text,
                            textCapitalization: TextCapitalization.words,
                            style: TextStyle(
                                fontSize: 16.0,
                                color: Colors.white),
                            decoration: InputDecoration(
                              labelText: "Nom d'utilisateur",
                              labelStyle: TextStyle(
                                  color: Colors.white
                              ),
                              icon: Icon(
                                FontAwesomeIcons.user,
                                color: Colors.white,
                              ),
                              hintText: "domiyns11",
                              hintStyle: TextStyle(
                                color: Colors.white,
                                  fontSize: 16.0),
                            ),
                          ),

                          SizedBox(
                              height: 15.0
                          ),


                          TextField(
                            focusNode: myFocusNodeEmail,
                            controller: signupEmailController,
                            keyboardType: TextInputType.emailAddress,
                            style: TextStyle(
                                fontSize: 16.0,
                                color: Colors.white),
                            decoration: InputDecoration(
                              labelText: "Adresse Mail",
                              labelStyle: TextStyle(
                                  color: Colors.white
                              ),
                              icon: Icon(
                                FontAwesomeIcons.envelope,
                                color: Colors.white,
                              ),
                              hintText: "domiyns@example.com",
                              hintStyle: TextStyle(
                                color: Colors.white,
                                  fontSize: 16.0),
                            ),
                          ),

                          SizedBox(
                              height: 15.0
                          ),

                          TextField(
                            focusNode: myFocusNodePhone,
                            controller: signupPhoneController,
                            keyboardType: TextInputType.phone,
                            style: TextStyle(
                                fontSize: 16.0,
                                color: Colors.white),
                            decoration: InputDecoration(
                              labelText: "N° Téléphone",
                              labelStyle: TextStyle(
                                  color: Colors.white
                              ),
                              icon: Icon(
                                FontAwesomeIcons.phone,
                                color: Colors.white,
                              ),
                              hintText: "+243 999 999 999",
                              hintStyle: TextStyle(
                                color: Colors.white,
                                  fontSize: 16.0),
                            ),
                          ),

                          SizedBox(
                              height: 15.0
                          ),


                          TextField(
                            focusNode: myFocusNodePassword,
                            controller: signupPasswordController,
                            obscureText: _obscureTextSignup,
                            style: TextStyle(
                                fontSize: 16.0,
                                color: Colors.white),
                            decoration: InputDecoration(
                              labelText: "Mot de passe",
                              labelStyle: TextStyle(
                                  color: Colors.white
                              ),
                              icon: Icon(
                                FontAwesomeIcons.lock,
                                color: Colors.white,
                              ),
                              hintText: "12345678",
                              hintStyle: TextStyle(
                                color: Colors.white,
                                  fontSize: 16.0),
                              suffixIcon: GestureDetector(
                                onTap: _toggleSignup,
                                child: Icon(
                                  _obscureTextSignup
                                      ? FontAwesomeIcons.eye
                                      : FontAwesomeIcons.eyeSlash,
                                  size: 15.0,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),

                      SizedBox(
                          height: 15.0
                      ),


                      TextField(
                        controller: signupConfirmPasswordController,
                        obscureText: _obscureTextSignupConfirm,
                        style: TextStyle(
                            fontSize: 16.0,
                            color: Colors.white),
                        decoration: InputDecoration(
                          labelText: "Confirmation MDP",
                          labelStyle: TextStyle(
                              color: Colors.white
                          ),
                          icon: Icon(
                            FontAwesomeIcons.lock,
                            color: Colors.white,
                          ),
                          hintText: "12345678",
                          hintStyle: TextStyle(
                              fontSize: 16.0,
                            color: Colors.white
                          ),
                          suffixIcon: GestureDetector(
                            onTap: _toggleSignupConfirm,
                            child: Icon(
                              _obscureTextSignupConfirm
                                  ? FontAwesomeIcons.eye
                                  : FontAwesomeIcons.eyeSlash,
                              size: 15.0,
                              color: Colors.white,
                            ),
                          ),
                        )
                        ),

                        ],
                      ),
                    ),
                  ),

                  SizedBox(
                      height: 20.0
                  ),

                  Center(
                    child: button("INSCRIPTION", (){
                      if(signupNameController.text.isEmpty ||
                      signupPasswordController.text.isEmpty ||
                      signupConfirmPasswordController.text.isEmpty ||
                      signupPhoneController.text.isEmpty ||
                      signupEmailController.text.isEmpty)
                      {
                      toast("Completez toute les cases");
                      }
                      else if (signupPasswordController.text.length < 6){
                      toast("Mot de passe trop court");}
                      else if (signupConfirmPasswordController.text != signupPasswordController.text)
                      {
                      toast("Mot de passe de confirmation différent");
                      }
                        else {
                          SignUp(
                              signupEmailController.text,
                              signupPasswordController.text,
                              signupPhoneController.text,
                              signupNameController.text,
                              context,
                              _scaffoldKey
                          );
                        }}
                      ),
                  )
                ],
              ),
            )
        ),
      ),
    );
  }

  void _toggleSignup() {
    setState(() {
      _obscureTextSignup = !_obscureTextSignup;
    });
  }

  void _toggleSignupConfirm() {
    setState(() {
      _obscureTextSignupConfirm = !_obscureTextSignupConfirm;
    });
  }

}