import 'package:app/src/bloc/review-bloc.dart';
import 'package:app/src/common/helper.dart';
import 'package:app/src/data_layer/models/product.dart';
import 'package:app/src/data_layer/repositories/customer_repository.dart';
import 'package:app/src/theme/colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

import '../../../localizations.dart';

class ReviewWidget extends StatelessWidget {
  final Product product;

  ReviewWidget({
    Key key,
    @required this.product,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(boxShadow: [
        BoxShadow(
          color: Color(0xFFfae3e2).withOpacity(0.1),
          spreadRadius: 1,
          blurRadius: 1,
          offset: Offset(0, 1),
        ),
      ]),
      child: Card(
        color: Colors.white,
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: const BorderRadius.all(
            Radius.circular(5.0),
          ),
        ),
        child: Column(
          children: [
            RatingBar.builder(
              initialRating: product.averageRating,
              minRating: 1,
              ignoreGestures: true,
              direction: Axis.horizontal,
              allowHalfRating: true,
              itemCount: 5,
              itemPadding: EdgeInsets.symmetric(horizontal: 4.0),
              itemBuilder: (context, _) => Icon(
                Icons.star,
                color: Colors.amber,
              ),
              onRatingUpdate: (rating) {},
            ),
            Align(
              alignment: Alignment.center,
              child: TextButton(
                child: Text(AppLocalizations.of(context).rate),
                style: TextButton.styleFrom(
                  primary: Colors.white,
                  backgroundColor: primaryColor,
                  onSurface: Colors.grey,
                ),
                onPressed: () {
                  _showRateStarsSheet(context);
                },
              ),
            )
          ],
        ),
      ),
    );
  }

  void _showRateStarsSheet(context) {
    OverlayEntry loader = Helper.overlayLoader(context);

    showModalBottomSheet(
        context: context,
        builder: (BuildContext bc) {
          return Container(
            height: 200,
            child: Column(
              children: [
                SizedBox(
                  height: 20,
                ),
                Text(AppLocalizations.of(context).product_rating,
                    style: TextStyle(fontSize: 18)),
                RatingBar.builder(
                  initialRating: 0,
                  minRating: 1,
                  direction: Axis.horizontal,
                  allowHalfRating: true,
                  itemCount: 5,
                  itemPadding: EdgeInsets.symmetric(horizontal: 4.0),
                  itemBuilder: (context, _) => Icon(
                    Icons.star,
                    color: Colors.amber,
                  ),
                  onRatingUpdate: (rating) {
                    print(rating);
                    product.currentRating = rating;
                  },
                ),
                SizedBox(
                  height: 20,
                ),
                Align(
                  alignment: Alignment.center,
                  child: TextButton(
                    child: Text(AppLocalizations.of(context).rate_now,
                        style: TextStyle(fontSize: 16)),
                    style: TextButton.styleFrom(
                      primary: Colors.white,
                      backgroundColor: primaryColor,
                      onSurface: Colors.grey,
                    ),
                    onPressed: () {
                      if (currentCustomer.value == null ||
                          currentCustomer.value.id == null) {
                        Navigator.of(context)
                            .pushReplacementNamed('/pages', arguments: 3);
                      } else {
                        Overlay.of(context).insert(loader);
                        print(product.currentRating);
                        reviewBloc
                            .submitReview(product, currentCustomer.value)
                            .then((value) {})
                            .catchError((e) {
                          loader.remove();
                          print(e.toString());
                        }).whenComplete(() {
                          Navigator.pop(context);
                          Helper.hideLoader(loader);
                          Helper.showSnackSuccessMessage(
                              context,
                              AppLocalizations.of(context)
                                  .thanks_for_reviewing);
                        });
                      }
                    },
                  ),
                )
              ],
            ),
          );
        });
  }
}
