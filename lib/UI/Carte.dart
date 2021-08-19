import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

import '../globalsvariable.dart';

class Carte extends StatefulWidget{

  List<dynamic> item;
  Carte({this.item});

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _Carte();
  }
}

class _Carte extends State<Carte>{

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        leading: backButton(context),
        elevation: 0.0,
      ),
      backgroundColor: Colors.black,
      body: Center(
        child: Padding(
          padding: EdgeInsets.all(10.0),
          child: CarouselSlider(
            options: CarouselOptions(
              height: width(context) / 1.1,
              aspectRatio: 16 / 9,
              autoPlay: false,
              enlargeCenterPage: false,
            ),
            items: widget.item.map((i) {
              return Builder(
                builder: (BuildContext context) {
                  return GestureDetector(
                    onTap: (){
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
        ),
      )
    );
  }
  @override
  void initState() {
  }
}