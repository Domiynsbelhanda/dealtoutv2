import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dealtoutv2/UI/Carte.dart';
import 'package:dealtoutv2/models/Articles.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../globalsvariable.dart';

class Details extends StatefulWidget{

  Articles item;
  Details({this.item});

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _Details();
  }
}

class _Details extends State<Details>{
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        elevation:0,
        leading: backButton(context),
        actions: [
          IconButton(
            icon: Icon(
              FontAwesomeIcons.search,
              color: Colors.white,
            ),
            onPressed: (){
              showSearchs(context);
            },
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Container(
          child: Padding(
            padding: EdgeInsets.all(10),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [

                CarouselSlider(
                  options: CarouselOptions(
                    height: width(context) / 2.2,
                    aspectRatio: 16 / 9,
                    autoPlay: true,
                    enlargeCenterPage: false,
                  ),
                  items: widget.item.image.map((i) {
                    return Builder(
                      builder: (BuildContext context) {
                        return GestureDetector(
                          onTap: (){
                            Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context){
                                  return Carte(item: widget.item.image);
                                })
                            );
                          },
                          child: Card(
                            elevation: 5.0,
                            child: Container(
                                width: MediaQuery.of(context).size.width,
                                child: Image(
                                  image: NetworkImage(i),
                                  fit: BoxFit.fitWidth,
                                )
                            ),
                          ),
                        );
                      },
                    );
                  }).toList(),
                ),

                SizedBox(height: 15.0),

                Text(
                  '${widget.item.nom}'.toUpperCase(),
                  style: TextStyle(
                    fontSize: width(context) / 12,
                    color: Colors.white,
                    letterSpacing: 2.0
                  ),
                ),

                SizedBox(height: 10.0),

                Text(
                  '${widget.item.fabricant}'.toUpperCase(),
                  style: TextStyle(
                    fontSize: width(context) / 15,
                    color: Colors.grey
                  ),
                ),

                SizedBox(height: 10.0),

                Text(
                  'CDF ${widget.item.prix}',
                  style: TextStyle(
                    fontSize: width(context) / 18,
                    fontWeight: FontWeight.normal,
                    color: Colors.blue
                  ),
                ),

                SizedBox(height: 10.0),

                Divider(),

                Padding(
                  padding: EdgeInsets.only(top: 0, bottom: 0),
                  child: Container(
                    color: Colors.white,
                    padding: EdgeInsets.all(5.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          'Categorie : ${widget.item.categorie}  |',
                          style: TextStyle(
                              fontSize: width(context) / 22,
                            color: Colors.black
                          ),
                        ),

                        VerticalDivider(),

                        SizedBox(width: 10),

                        Text(
                          '${widget.item.vue} vues',
                          style: TextStyle(
                            color: Colors.black
                          ),
                        )
                      ],
                    ),
                  ),
                ),

                Divider(),

                SizedBox(height: 10.0,),

                Text(
                  'Description : ',
                  style: TextStyle(
                    fontSize: width(context) / 20,
                    color: Colors.white
                  ),
                ),

                SizedBox(height: 10.0),

                Padding(
                  padding: const EdgeInsets.only(left: 15.0),
                  child: Text(
                    'Etat : ${widget.item.etat} \n${widget.item.description}',
                    style: TextStyle(
                        fontSize: width(context) / 22,
                      color: Colors.white
                    ),
                  ),
                ),

                SizedBox(height: 10.0),

                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    FlatButton(
                        onPressed: (){
                          toast('Article ajouté');
                        },
                        child: Container(
                          color: Colors.green,
                          child: Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Text(
                              'WHATSAPP',
                              style: TextStyle(
                                color: Colors.white,
                                letterSpacing: 2.0
                              ),
                            ),
                          ),
                        )
                    ),

                    FlatButton(
                        onPressed: (){
                          toast('Commande effectuée');
                        },
                        child: Container(
                          color: Colors.lightBlue,
                          child: Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Text(
                                'SMS',
                              style: TextStyle(
                                color: Colors.black,
                                letterSpacing: 2.0
                              ),
                            ),
                          ),
                        )
                    )
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  void initState() {
    FirebaseFirestore.instance
        .collection('Article')
        .doc(widget.item.id)
        .update({"vue": FieldValue.increment(1)});
  }
}