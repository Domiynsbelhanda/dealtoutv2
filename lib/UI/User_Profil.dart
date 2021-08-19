import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../globalsvariable.dart';

class UserProfil extends StatelessWidget {

  final FocusNode myfocusUserName = FocusNode();
  final FocusNode numeroTelephone = FocusNode();
  final FocusNode myfocusVille = FocusNode();
  final FocusNode myfocusGenre = FocusNode();

  TextEditingController userNameController = new TextEditingController();
  TextEditingController numeroTelephoneController = new TextEditingController();
  TextEditingController villeController = new TextEditingController();
  TextEditingController genreController = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      backgroundColor: Colors.black,
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Profil'.toUpperCase(),
                style: TextStyle(
                  fontSize: width(context) / 15,
                  color: Colors.white,
                  letterSpacing: 2.0
                ),
              ),

              SizedBox(height: 20),

              Text(
                '${your_profil.email}',
                style: TextStyle(
                  fontSize: width(context) / 20,
                  color: Colors.white
                ),
              ),

              SizedBox(
                height: 15,
              ),

              TextField(

                focusNode: myfocusUserName,
                controller: userNameController,
                style: TextStyle(
                    fontSize: 16.0,
                    color: Colors.white
                ),
                decoration: InputDecoration(
                  border: InputBorder.none,
                  hintText: '${your_profil.name}',
                  hintStyle: TextStyle(
                      fontSize: 17.0,
                    color: Colors.white
                  ),
                  suffixIcon: Icon(
                      FontAwesomeIcons.user,
                      size: 15.0,
                      color: Colors.white,
                    ),
                ),
              ),

              SizedBox(height: 15),

              TextField(
                focusNode: numeroTelephone,
                controller: numeroTelephoneController,
                style: TextStyle(
                    fontSize: 16.0,
                    color: Colors.white
                ),
                decoration: InputDecoration(
                  border: InputBorder.none,
                  hintText: '${your_profil.telephone}',
                  hintStyle: TextStyle(
                      fontSize: 17.0,
                    color: Colors.white
                  ),
                  suffixIcon: Icon(
                    FontAwesomeIcons.phone,
                    size: 15.0,
                    color: Colors.white,
                  ),
                ),
              ),

              SizedBox(height: 15),

              TextField(
                focusNode: myfocusVille,
                controller: villeController,
                style: TextStyle(
                    fontSize: 16.0,
                    color: Colors.white
                ),
                decoration: InputDecoration(
                  border: InputBorder.none,
                  hintText: your_profil.ville == null ? "Ta Ville" : '${your_profil.ville}',
                  hintStyle: TextStyle(
                      fontSize: 17.0,
                    color: Colors.white
                  ),
                  suffixIcon: Icon(
                    FontAwesomeIcons.city,
                    size: 15.0,
                    color: Colors.white,
                  ),
                ),
              ),

              SizedBox(height: 15),

              TextField(
                focusNode: myfocusGenre,
                controller: genreController,
                style: TextStyle(
                    fontSize: 16.0,
                    color: Colors.white
                ),
                decoration: InputDecoration(
                  border: InputBorder.none,
                  hintText: your_profil.genre == null ? "Genre" : '${your_profil.genre}',
                  hintStyle: TextStyle(
                      fontSize: 17.0,
                    color: Colors.white
                  ),
                  suffixIcon: Icon(
                    FontAwesomeIcons.userEdit,
                    size: 15.0,
                    color: Colors.white,
                  ),
                ),
              ),

              SizedBox(height: 15,),

              Center(child: button("Mettre à jour", () async{

                if(numeroTelephoneController.text != ''){
                  var data = {
                    "telephone": numeroTelephoneController.text,
                  };
                  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
                  await _firestore.collection('Users').doc(your_profil.uid).update(data);
                  toast('Profile Mise à jour');
                }

                if(userNameController.text != ''){
                  var data = {
                    "name": userNameController.text,
                  };
                  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
                  await _firestore.collection('Users').doc(your_profil.uid).update(data);
                  toast('Profile Mise à jour');
                }

                if(villeController.text != ''){
                  var data = {
                    "ville": villeController.text,
                  };
                  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
                  await _firestore.collection('Users').doc(your_profil.uid).update(data);
                  toast('Profile Mise à jour');
                }

                if(genreController.text != ''){
                  var data = {
                    "genre": genreController.text
                  };
                  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
                  await _firestore.collection('Users').doc(your_profil.uid).update(data);
                  toast('Profile Mise à jour');
                }
              }))
            ],
          ),
        ),
      ),
    );
  }
}