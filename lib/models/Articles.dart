import 'package:cloud_firestore/cloud_firestore.dart';

class Articles {
  String id;
  String nom;
  String fabricant;
  String prix;
  String categorie;
  int vue;
  List <dynamic> image;
  String description;
  String etat;
  Timestamp timestamp;
  String telephone;
  String uid;

  Articles({
    this.id,
    this.nom,
    this.prix,
    this.categorie,
    this.vue,
    this.image,
    this.fabricant,
    this.description,
    this.etat,
    this.timestamp,
    this.telephone,
    this.uid
  });
}