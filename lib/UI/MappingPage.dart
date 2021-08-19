import 'package:flutter/material.dart';

import '../globalsvariable.dart';
import 'Authentification.dart';
import 'Inscription.dart';

class MappingPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _MappingPage();
  }
}

class _MappingPage extends State<MappingPage>{
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      backgroundColor: Colors.black,
      body: Container(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Image(
                image: AssetImage(
                  'assets/images/logo.png',
                ),
                width: width(context) / 2.8,
              ),

              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  'DEAL TOUT V2',
                  style: TextStyle(
                      color: primaryColor,
                      fontSize: width(context) / 20,
                      fontWeight: FontWeight.bold,
                    letterSpacing: 3.0,
                  ),
                ),
              ),

              SizedBox(height: width(context) / 8,),

              button("Connexion", (){
                Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context){
                      return Authentification();
                    })
                );
              }),

              SizedBox(height: height(context) / 100,),

              button("Inscription", (){
                Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context){
                      return Inscription();
                    })
                );
              })
            ],
          ),
        ),
      ),
    );
  }

}