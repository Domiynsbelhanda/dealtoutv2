import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../globalsvariable.dart';

class PlusVues extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _PlusVues();
  }
}

class _PlusVues extends State<PlusVues>{
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
        backgroundColor: Colors.black,
        appBar: AppBar(
          backgroundColor: Colors.black,
          elevation: 0,
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
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Text(
                'Les plus vendus (${plusvues.length})'.toUpperCase(),
                style: TextStyle(
                    fontSize: width(context) / 15,
                  color: Colors.white,
                  letterSpacing: 2.0
                ),
              ),
            ),

            Expanded(
              child: Padding(
                padding: EdgeInsets.all(10.0),
                child: GridView.builder(
                  itemCount: plusvues.length,
                  shrinkWrap: true,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      mainAxisSpacing: 5.0,
                      crossAxisSpacing: 10.0,
                      childAspectRatio: (0.65)
                  ),
                  itemBuilder: (context, index) => GestureDetector(
                    child: item(plusvues[index], context, index),
                  ),
                ),
              ),
            )
          ],
        )
    );
  }
}