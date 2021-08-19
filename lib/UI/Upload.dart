import 'dart:io';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:chips_choice/chips_choice.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dealtoutv2/globalsvariable.dart';
import 'package:dealtoutv2/models/Categorie.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:image_pickers/image_pickers.dart';
import 'package:uuid/uuid.dart';

class Upload extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _Upload();
  }
}

class _Upload extends State<Upload>{

  int tag = 0;
  List<Categorie> options = categories;

  String categorie = categories[0].nom;

  List<Media> _listImagePaths;

  final FocusNode focusNom = FocusNode();
  final FocusNode focusPrix = FocusNode();
  final FocusNode focusFabricant = FocusNode();
  final FocusNode focusEtat = FocusNode();
  final FocusNode focusDescription = FocusNode();


  TextEditingController nomController = new TextEditingController();
  TextEditingController prixController = new TextEditingController();
  TextEditingController fabricantController = new TextEditingController();
  TextEditingController etatController = new TextEditingController();
  TextEditingController descriptionController = new TextEditingController();

  List<String> images = [];

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
                'Publication'.toUpperCase(),
                style: TextStyle(
                    fontSize: width(context) / 15,
                    color: Colors.white,
                    letterSpacing: 2.0
                ),
              ),

              SizedBox(height: 20),

              _listImagePaths == null ?
              Center(
                child: GestureDetector(
                  onTap: () async {
                    selectImages(context);
                  },
                  child: Container(
                    padding: EdgeInsets.all(10.0),
                    color: Colors.pink,
                    child: Text(
                      '+ Choisir 3 images'.toUpperCase(),
                      style: TextStyle(
                          fontSize: width(context) / 15,
                          color: Colors.white
                      ),
                    ),
                  ),
                ),
              ) : SizedBox(),

              SizedBox(height: 10),

              _listImagePaths == null ?
              Center(
                child: Text(
                  'Veuillez choisir 3 images',
                  style: TextStyle(
                      color: Colors.white
                  ),
                ),
              )
              :
              _listImagePaths != null && _listImagePaths.length < 3 ?
              Center(
                child: Text(
                  '3 images',
                  style: TextStyle(
                      color: Colors.white
                  ),
                ),
              )
                  :
              CarouselSlider(
                options: CarouselOptions(
                    height: width(context) / 2.2,
                    autoPlay: false,
                    enlargeCenterPage: false,
                    pageSnapping: true
                ),
                items: _listImagePaths.map((i) {
                  return Builder(
                    builder: (BuildContext context) {
                      return Card(
                        elevation: 5.0,
                        child: Container(
                            width: MediaQuery.of(context).size.width,
                            child: Image(
                              image: FileImage(File(i.path)),
                              fit: BoxFit.fitWidth,
                            )
                        ),
                      );
                    },
                  );
                }).toList(),
              ),
              
              SizedBox(height: 10.0),

              Center(
                child: Text(
                  'Categorie:',
                  style: TextStyle(
                    color: Colors.white
                  ),
                ),
              ),

              ChipsChoice<int>.single(
                crossAxisAlignment: CrossAxisAlignment.start,
                choiceActiveStyle: C2ChoiceStyle(
                    labelStyle: TextStyle(
                        color: Colors.blue
                    ),
                    avatarBorderColor: Colors.blue
                ),
                choiceStyle: C2ChoiceStyle(
                    labelStyle: TextStyle(
                        color: Colors.pink
                    )
                ),
                placeholder: "Categorie:",
                placeholderStyle: TextStyle(
                    color: Colors.white,
                    fontSize: 15.0
                ),
                value: tag,
                onChanged: (val) {
                  setState(() {
                    tag = val;
                    categorie = options[tag].nom;
                  });
                },
                choiceItems: C2Choice.listFrom<int, Categorie>(
                  source: options,
                  value: (i, v) => i,
                  label: (i, v) => v.nom,
                ),
              ),

              TextField(
                focusNode: focusNom,
                controller: nomController,
                style: TextStyle(
                    fontSize: 16.0,
                    color: Colors.white
                ),
                decoration: InputDecoration(
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.white),
                  ),
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.green),
                  ),
                  hintText: 'Nom du produit',
                  hintStyle: TextStyle(
                      fontSize: 17.0,
                      color: Colors.white
                  ),
                ),
              ),

              TextField(
                focusNode: focusPrix,
                controller: prixController,
                keyboardType: TextInputType.number,
                style: TextStyle(
                    fontSize: 16.0,
                    color: Colors.white
                ),
                decoration: InputDecoration(
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.white),
                  ),
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.green),
                  ),
                  hintText: 'Prix en CDF',
                  hintStyle: TextStyle(
                      fontSize: 17.0,
                      color: Colors.white
                  ),
                ),
              ),

              TextField(
                focusNode: focusFabricant,
                controller: fabricantController,
                keyboardType: TextInputType.text,
                style: TextStyle(
                    fontSize: 16.0,
                    color: Colors.white
                ),
                decoration: InputDecoration(
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.white),
                  ),
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.green),
                  ),
                  hintText: 'Fabricant ou marque',
                  hintStyle: TextStyle(
                      fontSize: 17.0,
                      color: Colors.white
                  ),
                ),
              ),

              TextField(
                focusNode: focusEtat,
                controller: etatController,
                keyboardType: TextInputType.text,
                style: TextStyle(
                    fontSize: 16.0,
                    color: Colors.white
                ),
                decoration: InputDecoration(
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.white),
                  ),
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.green),
                  ),
                  hintText: 'Etat',
                  hintStyle: TextStyle(
                      fontSize: 17.0,
                      color: Colors.white
                  ),
                ),
              ),

              TextField(
                focusNode: focusDescription,
                controller: descriptionController,
                keyboardType: TextInputType.multiline,
                maxLines: null,
                style: TextStyle(
                    fontSize: 16.0,
                    color: Colors.white
                ),
                decoration: InputDecoration(
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.white),
                  ),
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.green),
                  ),
                  hintText: 'Description',
                  hintStyle: TextStyle(
                      fontSize: 17.0,
                      color: Colors.white
                  ),
                ),
              ),

              SizedBox(height: 10.0),

              Center(
                child: button('PUBLIER', () async{

                  if(nomController.text.isEmpty){
                    toast('Veuillez entre un nom');
                    return;
                  }

                  if(prixController.text.isEmpty){
                    toast('Veuillez entre un prix');
                    return;
                  }

                  if(fabricantController.text.isEmpty){
                    toast('Veuillez entre un fabricant');
                    return;
                  }

                  if(etatController.text.isEmpty){
                    toast('Veuillez entre un état');
                    return;
                  }

                  if(descriptionController.text.isEmpty){
                    toast('Veuillez entre une description');
                    return;
                  }

                  int indice = 0;

                  images.clear();

                  for(var i in _listImagePaths){
                    var uuid = Uuid();
                    String uid = uuid.v1();
                    indice += 1;
                    uploadFile(i.path, uid, indice);
                  }

                }),
              )
            ],
          ),
        ),
      )
    );
  }

  uploadFile(path, uid, indice) async{
    showDialogs("Patienter", context);
    String url;
    final Reference postImageRef = FirebaseStorage.instance.ref().child("Datas");
    final TaskSnapshot uploadTask = await postImageRef
        .child('${uid}_${indice}jpg').putFile(File(path));
    var ImageUrl = await uploadTask.ref.getDownloadURL();
    url = ImageUrl.toString();
    images.add(url);
    Navigator.pop(context);
    if (images.length == 3){
      saveToData(images, uid);
    }
  }

  saveToData(url, uid){
    var data = {
      "key": your_profil.uid,
      "telephone": your_profil.telephone,
      "article": nomController.text,
      "image": url,
      "etat": etatController.text,
      "description": descriptionController.text,
      "prix": double.parse(prixController.text),
      "categorie": categorie,
      "vendue": false,
      "timestamp": FieldValue.serverTimestamp(),
      "id": uid,
      "fabricant": fabricantController.text,
      "vue": 0
    };
    final FirebaseFirestore firestore = FirebaseFirestore.instance;
    firestore.collection("Article").doc(uid).set(data);

    toast("Article publié");
    setState(() {
      nomController.clear();
      descriptionController.clear();
      prixController.clear();
      etatController.clear();
      _listImagePaths = null;
    });
  }

  Future<void> selectImages(context) async {
    await ImagePickers.pickerPaths(
        galleryMode: GalleryMode.image,
        selectCount: 3,
        showGif: false,
        showCamera: true,
        compressSize: 500,
        uiConfig: UIConfig(uiThemeColor: Color(0xffff0f50)),
        cropConfig: CropConfig(enableCrop: false, width: 2, height: 1)
    ).then((value) {
      if(value.length < 3){
        toast('Veuillez choisir 3 images.');
        setState(() {
          _listImagePaths = null;
        });
      }
      else {
        setState(() {
          _listImagePaths = value;
        });
      }
    });
  }
}