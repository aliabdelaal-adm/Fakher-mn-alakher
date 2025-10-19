class Product {
  static const IN_STOCK_STATUS = "instock";
  static const ON_BACK_ORDER_STATUS = "onbackorder";
  static const OUT_OF_STOCK_STATUS = "outofstock";

  int id;
  String name;
  String desc;
  String img;
  double price;
  double regularPrice;
  String sku;
  String stockStatus;
  List<dynamic> variations;
  int variationId = 0;
  String variationDesc = "";
  double averageRating;
  double currentRating = 0.0;
  String dateOnSaleFrom;
  String dateOnSaleTo;

  Product();

  Product.fromJson(Map json)
      : id = json['id'],
        name = json['name'] != null ? json['name'] : json['id'],
        img = (json['images'] != null && (json['images'] as List).length > 0)
            ? json['images'][0]['src']
            : " ",
        desc = json['short_description'] != null
            ? json['short_description']
            : "No description",
        price = (json['price'] != null && json['price'] != "")
            ? double.parse(json['price'])
            : 0.0,
        sku = json['sku'],
        regularPrice =
            json['regular_price'] != null && json['regular_price'] != ""
                ? double.parse(json['regular_price'])
                : null,
        variations = json['variations'],
        stockStatus = json['stock_status'],
        dateOnSaleFrom = json['date_on_sale_from'],
        dateOnSaleTo = json['date_on_sale_to'],
        averageRating =
            (json['average_rating'] != null && json['average_rating'] != "")
                ? double.parse(json['average_rating'])
                : 0.0;
}
