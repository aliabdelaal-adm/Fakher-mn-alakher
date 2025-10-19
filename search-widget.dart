import 'package:app/src/bloc/search-bloc.dart';
import 'package:app/src/bloc/variation-bloc.dart';
import 'package:app/src/common/helper.dart';
import 'package:app/src/data_layer/models/product.dart';
import 'package:app/src/theme/colors.dart';
import 'package:app/src/ui/widgets/product-widget.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import '../../../localizations.dart';

class SearchWidget extends StatefulWidget {
  @override
  _SearchWidgetState createState() => _SearchWidgetState();
}

class _SearchWidgetState extends State<SearchWidget> {
  var textChanged = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    searchBloc.clear();
  }

  @override
  void dispose() {
    // Clean up the focus node when the Form is disposed.
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: bgColor,
          toolbarHeight: 80,
          title:
              Image.asset('assets/img/logo.png', fit: BoxFit.cover, height: 80),
          centerTitle: true,
          elevation: 0,
          leading: IconButton(
            icon: Icon(
              Icons.arrow_back_ios,
              color: greyColor,
              size: 21,
            ),
            onPressed: () => Navigator.of(context).pop(),
          ),
          brightness: Brightness.light,
        ),
        body: Padding(
          padding: const EdgeInsets.only(left: 5, right: 5, top: 5, bottom: 5),
          child: textChanged
              ? Center(child: CircularProgressIndicator(), heightFactor: 6)
              : Container(
                  width: double.infinity,
                  child: Container(
                    alignment: Alignment.center,
                    padding:
                        EdgeInsets.only(left: 5, right: 5, top: 10, bottom: 10),
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        SizedBox(
                          height: 5,
                        ),
                        Container(
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.all(Radius.circular(20)),
                            border: Border.all(
                              color: Colors.grey,
                              width: 1,
                            ),
                          ),
                          child: TextFormField(
                            decoration: InputDecoration(
                                errorBorder: InputBorder.none,
                                border: InputBorder.none,
                                focusedBorder: InputBorder.none,
                                enabledBorder: InputBorder.none,
                                icon: Icon(
                                  Icons.search,
                                  color: greyColor,
                                  size: 30,
                                )),
                            autofocus: true,
                            textAlign: TextAlign.center,
                            onChanged: (text) {
                              searchBloc.searchProducts(text);
                              print(text);
                            },
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Container(
                          child: StreamBuilder<Object>(
                              stream: searchBloc.searchedProducts,
                              builder: (context, snapshot) {
                                if (snapshot.hasData &&
                                    (snapshot.data as List<Product>)
                                        .isNotEmpty) {
                                  // setState(() {
                                  //   textChanged = false;
                                  // });
                                  final results =
                                      (snapshot.data as List<Product>);
                                  return new Flexible(
                                    child: new ListView.builder(
                                        itemCount: results.length,
                                        itemBuilder:
                                            (BuildContext context, int index) {
                                          var desc = Helper.skipHtml(
                                              "${results[index].desc}");
                                          return new ListTile(
                                            onTap: () {
                                              variationFetchBloc.clear();
                                              variationFetchBloc
                                                  .fetchVariations(
                                                      results[index]
                                                          .id
                                                          .toString());
                                              Dialog errorDialog = Dialog(
                                                shape: RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            20.0)),
                                                //this right here
                                                child: Container(
                                                  height: MediaQuery.of(context)
                                                      .size
                                                      .height,
                                                  width: MediaQuery.of(context)
                                                      .size
                                                      .width,
                                                  child: ProductWidget(
                                                      product: results[index],
                                                      isVariated: results[index]
                                                              .variations
                                                              .length >
                                                          0),
                                                ),
                                              );
                                              showDialog(
                                                  context: context,
                                                  builder:
                                                      (BuildContext context) =>
                                                          errorDialog);
                                            },
                                            leading: ConstrainedBox(
                                              constraints: BoxConstraints(
                                                minWidth: 44,
                                                minHeight: 44,
                                                maxWidth: 64,
                                                maxHeight: 64,
                                              ),
                                              child: CachedNetworkImage(
                                                width: 80,
                                                height: 60,
                                                imageUrl:
                                                    "${results[index].img}",
                                                fit: BoxFit.cover,
                                                fadeInCurve:
                                                    Curves.linearToEaseOut,
                                                fadeOutCurve:
                                                    Curves.easeInOutBack,
                                              ),
                                            ),
                                            title:
                                                Text("${results[index].name}"),
                                            subtitle: Text(
                                                desc.length > 100
                                                    ? desc.substring(0, 80) +
                                                        ".."
                                                    : desc,
                                                style: TextStyle(
                                                  fontSize: 12,
                                                )),
                                          );
                                        }),
                                  );
                                } else if (snapshot.hasData &&
                                    (snapshot.data as List<Product>).isEmpty) {
                                  return Padding(
                                    padding:
                                        const EdgeInsets.fromLTRB(0, 40, 0, 0),
                                    child: Text(
                                      AppLocalizations.of(context)
                                          .no_result_found,
                                      style: TextStyle(
                                          fontSize: 22,
                                          color: primaryColor,
                                          fontWeight: FontWeight.bold),
                                      textAlign: TextAlign.left,
                                    ),
                                  );
                                }

                                return Container();
                              }),
                        )
                      ],
                    ),
                  ),
                ),
        ));
  }
}
