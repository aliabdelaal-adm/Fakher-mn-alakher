import 'package:app/src/common/helper.dart';

class Variation {
  final int id;
  final String desc;
  final double price;
  final double regularPrice;
  final String sku;
  final String img;

  Variation.fromJson(Map json)
      : id = json['id'],
        desc = json['description'] != null
            ? Helper.skipHtml(json['description'])
            : "",
        img = (json['image'] != null )
            ? json['image']['src']
            : " ",
        price = (json['price'] != null && json['price'] != "")
            ? double.parse(json['price'])
            : 0.0,
        sku = json['sku'],
        regularPrice =
            json['regular_price'] != null && json['regular_price'] != ""
                ? double.parse(json['regular_price'])
                : null;
}
