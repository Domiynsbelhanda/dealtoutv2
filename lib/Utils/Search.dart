import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../globalsvariable.dart';

class TheSearch extends SearchDelegate<String> {
  TheSearch({this.contextPage});

  BuildContext contextPage;

  @override
  String get searchFieldLabel => "Entrez le nom du produit";

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: Icon(Icons.clear),
        onPressed: () {
          query = "";
        },
      )
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      color: Colors.black,
      icon: AnimatedIcon(
        icon: AnimatedIcons.menu_arrow,
        progress: transitionAnimation,
      ),
      onPressed: () {
        close(context, null);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.black,
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            Expanded(
              child: Padding(
                padding: EdgeInsets.all(10.0),
                child: GridView.builder(
                  itemCount: nouveaute.where((element) => element.nom.toLowerCase().contains(query.toLowerCase())).toList().length,
                  shrinkWrap: true,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      mainAxisSpacing: 5.0,
                      crossAxisSpacing: 10.0,
                      childAspectRatio: (0.65)
                  ),
                  itemBuilder: (context, index) => GestureDetector(
                    child: item(
                        nouveaute.where((element) => element.nom.contains(query.toLowerCase())).toList()[index],
                        context,
                        index
                    ),
                  ),
                ),
              ),
            )
          ],
        )
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.black,
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            Expanded(
              child: Padding(
                padding: EdgeInsets.all(10.0),
                child: GridView.builder(
                  itemCount: nouveaute.where((element) => element.nom.toLowerCase().contains(query.toLowerCase())).toList().length,
                  shrinkWrap: true,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      mainAxisSpacing: 5.0,
                      crossAxisSpacing: 10.0,
                      childAspectRatio: (0.65)
                  ),
                  itemBuilder: (context, index) => GestureDetector(
                    child: item(
                        nouveaute.where((element) => element.nom.toLowerCase().contains(query.toLowerCase())).toList()[index],
                        context,
                        index
                    ),
                  ),
                ),
              ),
            )
          ],
        )
    );
  }
}