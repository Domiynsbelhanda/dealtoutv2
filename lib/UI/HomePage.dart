import 'package:bottom_navy_bar/bottom_navy_bar.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dealtoutv2/Utils/Authentification.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../globalsvariable.dart';
import 'Categorie.dart';
import 'Nouveaute.dart';
import 'PlusVues.dart';
import 'Upload.dart';
import 'User_Profil.dart';

class HomePage extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _HomePage();
  }
}

class _HomePage extends State<HomePage>{

  int _currentIndex = 0;
  PageController _pageController;

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      backgroundColor: Colors.black,
      bottomNavigationBar: BottomNavyBar(
        backgroundColor: Colors.transparent,
        selectedIndex: _currentIndex,
        showElevation: true, // use this to remove appBar's elevation
        onItemSelected: (index) => setState(() {
          _currentIndex = index;
        }),
        items: [
          BottomNavyBarItem(
            icon: Icon(Icons.apps),
            title: Text('Accueil'),
            activeColor: Colors.red,
          ),
          BottomNavyBarItem(
              icon: Icon(Icons.people),
              title: Text('Profil'),
              activeColor: Colors.purpleAccent
          ),
          BottomNavyBarItem(
              icon: Icon(Icons.add),
              title: Text('Publiler'),
              activeColor: Colors.pink
          ),
          BottomNavyBarItem(
              icon: Icon(Icons.settings),
              title: Text('Paramètre'),
              activeColor: Colors.blue
          ),
        ],
      ),
      body: pages.elementAt(_currentIndex)
    );
  }

  List pages = [
    Home(),
    UserProfil(),
    Upload(),
    UserProfil()
  ];

  @override
  void initState() {
    SystemChrome.setEnabledSystemUIOverlays([]);
    current_User();
    data();
    super.initState();
  }

  @override
  void dispose() {
    SystemChrome.setEnabledSystemUIOverlays(SystemUiOverlay.values);
    super.dispose();
  }
}

class Home extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _Home();
  }
}

class _Home extends State<Home>{

  List<dynamic> publicite = [];

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(0.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              GestureDetector(
                onTap:() {
                  showSearchs(context);
                },
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Card(
                        elevation: 5.0,
                        shadowColor: Colors.white,
                        borderOnForeground: true,
                        color: Colors.black,
                        child: Container(
                          width: width(context) / 1.3,
                          margin: EdgeInsets.all(width(context) / 25),
                          child: Row(
                            children: [
                              Icon(
                                  FontAwesomeIcons.search,
                                  color: Colors.white,
                                  size: width(context) / 20
                              ),

                              Container(
                                child: VerticalDivider(
                                  color: Colors.grey,
                                ),
                              ),

                              Text(
                                'Rechercher',
                                style: TextStyle(
                                  fontFamily: 'Sergoe UI',
                                  color: Colors.white,
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              SizedBox(
                height: width(context) / 20,
              ),

              CarouselSlider(
                options: CarouselOptions(
                    height: width(context) / 2.2,
                    autoPlay: true,
                    enlargeCenterPage: false,
                    pageSnapping: true
                ),
                items: publicite.map((i) {
                  return Builder(
                    builder: (BuildContext context) {
                      return Card(
                        elevation: 5.0,
                        child: Container(
                            width: MediaQuery.of(context).size.width,
                            child: Image(
                              image: NetworkImage(i),
                              fit: BoxFit.fitWidth,
                            )
                        ),
                      );
                    },
                  );
                }).toList(),
              ),

              SizedBox(
                height: width(context) / 20,
              ),

              Padding(
                padding: const EdgeInsets.only(left:10.0, top: 10.0),
                child: Text(
                  'Categories'.toUpperCase(),
                  style: TextStyle(
                      fontSize: width(context)/18,
                      color: Colors.white,
                      letterSpacing: 2.0
                  ),
                ),
              ),

              Padding(
                padding: EdgeInsets.only(left: 10.0, top: 10.0),
                child: Categorie(),
              ),

              Padding(
                padding: EdgeInsets.only(left: 10.0, top: 10.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Nouveauté'.toUpperCase(),
                      style: TextStyle(
                          fontSize: width(context)/18,
                          color: Colors.white,
                          letterSpacing: 2.0
                      ),
                    ),

                    FlatButton(
                      onPressed: (){
                        Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context){
                              return Nouveaute();
                            })
                        );
                      },
                      child: Text(
                        'voir tout'.toUpperCase(),
                        style: TextStyle(
                            color: Colors.white
                        ),
                      ),
                    )
                  ],
                ),
              ),

              SizedBox(
                height: 5.0,
              ),

              Container(
                  margin: EdgeInsets.only(left:10.0, right: 10.0),
                  height: width(context) / 1.5,
                  child: ListView.builder(
                    shrinkWrap: true,
                    scrollDirection: Axis.horizontal,
                    itemCount: nouveaute.length < 10 ? nouveaute.length : 10,
                    itemBuilder: (context, index){
                      return new GestureDetector(
                          child: item(nouveaute[index], context, index)
                      );
                    },
                  )
              ),


              Padding(
                padding: EdgeInsets.only(left: 10.0, top: 10.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Les plus vendus'.toUpperCase(),
                      style: TextStyle(
                          fontSize: width(context)/18,
                          color: Colors.white,
                          letterSpacing: 2.0
                      ),
                    ),

                    FlatButton(
                      onPressed: (){
                        Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context){
                              return PlusVues();
                            })
                        );
                      },
                      child: Text(
                        'voir tout'.toUpperCase(),
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                    )
                  ],
                ),
              ),

              Container(
                  margin: EdgeInsets.only(left:10.0, right: 10.0),
                  height: width(context) / 1.5,
                  child: ListView.builder(
                    shrinkWrap: true,
                    scrollDirection: Axis.horizontal,
                    itemCount: plusvues.length < 10 ? plusvues.length : 10,
                    itemBuilder: (context, index){
                      return new GestureDetector(
                          child: item(plusvues[index], context, index)
                      );
                    },
                  )
              ),

              SizedBox(height: 20.0)
            ],
          ),
        ),
      );
    }

  Widget Categorie(){
    return new Container(
        height:40.0,
        child: new ListView.builder(
          shrinkWrap: true,
          scrollDirection: Axis.horizontal,
          itemCount: categories.length,
          itemBuilder: (context, index){
            return new GestureDetector(
              onTap: (){
                Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context){
                      return Categories(categorie: categories[index].nom);
                    })
                );
              },
              child: new Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(4.0),
                ),
                child: new Container(
                    height: MediaQuery.of(context).size.width / 3,
                    width: MediaQuery.of(context).size.width / 3,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(4.0))
                    ),
                    child:
                    new Stack(children: <Widget>[
                      new Container(
                          decoration: BoxDecoration(
                              color: Colors.transparent,
                              image: DecorationImage(image: AssetImage(categories[index].image), fit: BoxFit.cover),
                              borderRadius: BorderRadius.all(Radius.circular(4.0))
                          )
                      ),

                      new Container(
                        decoration: BoxDecoration(
                            color: categories[index].color.withOpacity(0.8),
                            borderRadius: BorderRadius.all(Radius.circular(4))
                        ),
                      ),

                      new Center(child: new Text(
                        categories[index].nom.toString().toUpperCase(),
                        style: new TextStyle(
                            color: Colors.white,
                            fontSize: 12.0,
                            fontWeight: FontWeight.bold
                        ),
                      ),),

                    ],
                    )
                ),
              ),
            );
          },
        )
    );
  }

  @override
  void initState() {
    FirebaseFirestore.instance
        .collection('slider')
        .doc('oB9M5Pg8W7sDwGgIgZzi')
        .snapshots().forEach((element) {
          setState(() {
            publicite = element.data()['caroussel'];
          });
    });

    data();
  }
}