import 'package:flutter/material.dart';

import '../globalsvariable.dart';

class SplashScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _SplashScreen();
  }
}

class _SplashScreen extends State<SplashScreen>{
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
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
                width: width(context) / 1.5,
              ),

              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  'Deal Tout V2',
                  style: TextStyle(
                    color: primaryColor,
                    fontSize: width(context) / 13,
                    fontWeight: FontWeight.bold
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

}