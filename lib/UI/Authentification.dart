import 'package:dealtoutv2/UI/HomePage.dart';
import 'package:dealtoutv2/Utils/Authentification.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../globalsvariable.dart';

class Authentification extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _Authentification();
  }
}

class _Authentification extends State<Authentification>{

  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  final FocusNode myFocusNodeEmailLogin = FocusNode();
  final FocusNode myFocusNodePasswordLogin = FocusNode();

  TextEditingController loginemailController = new TextEditingController();
  TextEditingController loginPasswordController = new TextEditingController();

  bool _obscureTextLogin = true;

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
      body: Container(
        child: Padding(
          padding: EdgeInsets.all(width(context) / 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Text(
                  "Authentification".toUpperCase(),
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
                        focusNode: myFocusNodeEmailLogin,
                        controller: loginemailController,
                        keyboardType: TextInputType.emailAddress,
                        style: TextStyle(
                            fontSize: 16.0,
                            color: Colors.white
                        ),
                        decoration: InputDecoration(
                          labelText: "Adresse Mail",
                          labelStyle: TextStyle(
                            color: Colors.white
                          ),
                          icon: Icon(
                            FontAwesomeIcons.envelope,
                            color: Colors.white,
                            size: 22.0,
                          ),
                          hintText: "domiyns@example.com",
                          hintStyle: TextStyle(
                            color: Colors.white
                          )
                        ),
                      ),

                      SizedBox(
                        height: 15.0
                      ),


                      TextField(
                            focusNode: myFocusNodePasswordLogin,
                            controller: loginPasswordController,
                            obscureText: _obscureTextLogin,
                            style: TextStyle(
                                fontSize: 16.0,
                                color: Colors.white
                            ),
                            decoration: InputDecoration(
                              labelText: "Mot de passe",
                              labelStyle: TextStyle(
                                  color: Colors.white
                              ),
                              icon: Icon(
                                FontAwesomeIcons.lock,
                                size: 22.0,
                                color: Colors.white,
                              ),
                              hintText: "12345678",
                              hintStyle: TextStyle(
                                  fontSize: 17.0,
                                color: Colors.white
                              ),
                              suffixIcon: GestureDetector(
                                onTap: _toggleLogin,
                                child: Icon(
                                  _obscureTextLogin
                                      ? FontAwesomeIcons.eyeSlash
                                      : FontAwesomeIcons.eye,
                                  size: 15.0,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),

                    ],
                  ),
                ),
              ),

              SizedBox(
                height: 20.0
              ),

              Center(
                child: button("CONNEXION", (){
                  if(
                  loginemailController.text.isEmpty
                      || loginPasswordController.text.isEmpty){
                    toast("Completez toute les cases correctement.");
                  } else if (loginPasswordController.text.length < 8){
                    toast("Mot de passe trop court");
                  }
                  else {

                    SignIn(
                        loginemailController.text,
                        loginPasswordController.text,
                        context, _scaffoldKey
                    );

                  }
                }),
              )
            ],
          ),
        )
      ),
    );
  }

  void _toggleLogin() {
    setState(() {
      _obscureTextLogin = !_obscureTextLogin;
    });
  }

}