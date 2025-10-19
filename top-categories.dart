import 'package:app/src/bloc/categories_fetch_bloc.dart';
import 'package:app/src/bloc/products_fetch_bloc.dart';
import 'package:app/src/data_layer/models/category.dart';
import 'package:app/src/theme/colors.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class TopCategories extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<Object>(
        stream: categoriesFetchBloc.categories,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            final results = snapshot.data as List<Category>;
            productsFetchBloc.fetchProducts(results.first.id.toString());

            return Container(
              height: 80,
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: _buildResults(results, productsFetchBloc),
              ),
            );
          } else if (snapshot.hasError) {
            return Text(snapshot.error.toString());
          }
          return Center(child: CircularProgressIndicator());
        });
  }
}

List<Widget> _buildResults(
    List<Category> categories, ProductsFetchBloc productBloc) {
  List<Widget> widgets = <Widget>[];

  for (var category in categories) {
    widgets.add(new TopMenuTiles(
        bloc: productBloc,
        id: category.id.toString(),
        name: category.name,
        imageUrl: category.img,
        slug: ""));
  }

  return widgets;
}

class TopMenuTiles extends StatelessWidget {
  final ProductsFetchBloc bloc;
  final String id;
  final String name;
  final String imageUrl;
  final String slug;

  TopMenuTiles(
      {Key key,
        @required this.bloc,
        @required this.id,
        @required this.name,
        @required this.imageUrl,
        @required this.slug})
      : super(key: key);

  @override
  Widget build(BuildContext context) {

    return InkWell(
      splashColor: Colors.yellow,
      highlightColor: Colors.blue,
      focusColor: Colors.red,

      onTap: () {
        bloc.clear();
        bloc.fetchProducts(id);
        print("Category " + id);
      },
      child: Column(
        children: <Widget>[
          Container(
            padding: EdgeInsets.only(left: 10, right: 5, top: 5),
            decoration: new BoxDecoration(boxShadow: [
              new BoxShadow(
                color: shadowColor,
                blurRadius: 25.0,
                offset: Offset(0.0, 0.75),
              ),
            ]),
            child: Card(
                color: Colors.white,
                elevation: 0,
                shape: RoundedRectangleBorder(
                  borderRadius: const BorderRadius.all(
                    Radius.circular(3.0),
                  ),
                ),
                child: Container(
                  width: 40,
                  height: 40,
                  child: Center(

                      child: CachedNetworkImage(
                        placeholder: (context, url) => Image.asset(
                          'assets/img/maleh_logo.png',
                          fit: BoxFit.cover,
                        ),
                        imageUrl: this.imageUrl,
                        width: 32,
                        height: 32,
                        fit: BoxFit.fill,
                        fadeInCurve: Curves.linearToEaseOut,
                        fadeOutCurve: Curves.easeInOutBack,
                      )),
                )),
          ),
          Text(name,
              style: TextStyle(
                  color: Color(0xFF6e6e71),
                  fontSize: 12,
                  fontWeight: FontWeight.w600)),
        ],
      ),
    );
  }
}
