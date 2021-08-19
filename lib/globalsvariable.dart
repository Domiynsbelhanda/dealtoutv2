import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dealtoutv2/UI/HomePage.dart';
import 'package:dealtoutv2/UI/User_Profil.dart';
import 'package:dealtoutv2/models/Userss.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import './models/Categorie.dart';
import './models/Articles.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'UI/Details.dart';
import 'Utils/Authentification.dart';
import 'Utils/ProgressDialog.dart';
import 'Utils/Search.dart';
import 'models/ItemCard.dart';

const primaryColor = Colors.white;

List articles = nouveaute;

List<Categorie> categories = [
  Categorie(
      nom: 'Habillement',
      nom: 'Habillement',
      image: 'assets/images/bag_1.png',
      color: Colors.blue
  ),

  Categorie(
      nom: 'Telephone',
      image: 'assets/images/bag_2.png',
      color: Colors.red
  ),

  Categorie(
      nom: 'Automobile',
      image: 'assets/images/bag_3.png',
      color: Colors.green
  )
];

double width(context){
  return MediaQuery.of(context).size.width;
}

double height (context){
  return MediaQuery.of(context).size.height;
}

Widget button(String titre ,action()){
  return FlatButton(
      onPressed: () => action(),
      child: Card(
        elevation: 5.0,
        shadowColor: Colors.white,
        borderOnForeground: true,
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(2.0),
            color: Colors.white
          ),

          child: Padding(
              padding: EdgeInsets.only(top: 10, bottom: 10, left: 20, right: 20),
              child: Text(
                titre.toUpperCase(),
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.black,
                  letterSpacing: 2,
                ),
                textAlign: TextAlign.center,
              )
          ),
        ),
      )
  );
}

Widget backButton(context){
  return FlatButton(
    child: Icon(
      FontAwesomeIcons.arrowAltCircleLeft,
      size: width(context) / 15,
      color: Colors.white,
    ),
    onPressed: (){
      Navigator.pop(context);
    },
  );
}

toast(String message){
  Fluttertoast.showToast(
      msg: message,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 1,
      textColor: Colors.black,
      fontSize: 16.0
  );
}

Widget item(article, context, indice){
  return GestureDetector(
    onTap: (){
      Navigator.push(
          context,
          MaterialPageRoute(builder: (context){
        return Details(item: article);
      }));
    },
    child: Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Card(
            elevation: 2,
            shadowColor: Colors.white,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(5.0),
              child: Image(
                image: NetworkImage(
                    '${article.image[0]}'
                ),
                width: width(context) / 2.6,
                height: width(context) / 2,
                fit: BoxFit.fitHeight,
              ),
            ),
          ),

          SizedBox(
            height: 10.0,
          ),

          Text(
              'CDF ${article.prix}'.toUpperCase(),
            style: TextStyle(
              color: Colors.white
            ),
          ),

          SizedBox(
            height: 2.0,
          ),

          Text(
              '${article.nom}'.toUpperCase(),
            style: TextStyle(
              color: Colors.white
            ),
          ),
        ],
      ),
    ),
  );
}

showDialogs(String text, context){
  showDialog(
    barrierDismissible: false,
    context: context,
    builder: (BuildContext context) => ProgressDialog(status: text),
  );
}

current_User() async {
  await FirebaseFirestore.instance
      .collection('Users')
      .doc(users.uid)
      .snapshots().forEach((element) {
        your_profil = Userss(
          uid: element.data()['key'],
          email: element.data()['email'],
          name: element.data()['name'],
          telephone: element.data()['telephone'],
          ville: element.data()['ville'],
          genre: element.data()['genre']
        );
  });
}

data() async {
  Query collectionReference = await FirebaseFirestore.instance
      .collection("Article")
      .orderBy('timestamp', descending: true);

  nouveaute = [];
  collectionReference
      .snapshots()
      .listen((data) => data.docs.forEach((doc) {
          nouveaute.add(
            new Articles(
              id: doc['id'],
              nom: doc['article'],
              prix: doc['prix'],
              categorie: doc['categorie'],
              vue: doc['vue'],
              image: doc['image'],
              fabricant: doc['fabricant'],
              description: doc['description'],
              etat: doc['etat'],
              timestamp: doc['timestamp'],
              telephone: doc['telephone'],
              uid: doc['key']
            )
          );
  })
  );

  plusvues = [];

  Query collectionReference1 = await FirebaseFirestore.instance
      .collection("Article")
      .orderBy('vue', descending: true);

  collectionReference1
      .snapshots()
      .listen((data) => data.docs.forEach((doc) {
      plusvues.add(
          new Articles(
              id: doc['id'],
              nom: doc['article'],
              prix: doc['prix'],
              categorie: doc['categorie'],
              vue: doc['vue'],
              image: doc['image'],
              fabricant: doc['fabricant'],
              description: doc['description'],
              etat: doc['etat'],
              timestamp: doc['timestamp'],
              telephone: doc['telephone'],
              uid: doc['key']
          )
      );
  })
  );
}

Future<void> showSearchs(context) async {
  await showSearch(
    context: context,
    delegate: TheSearch(contextPage: context),
    query: "Nom du produit",
  );
}

Userss your_profil;

List<Articles> nouveaute;

List<Articles> plusvues;