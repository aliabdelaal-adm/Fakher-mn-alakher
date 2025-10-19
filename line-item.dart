class LineItem {
  int productId;
  int quantity;
  String name;
  String total;
  int variationId;

  LineItem(this.productId, this.quantity,this.variationId);

  LineItem.fromJson(Map json)
      : productId = json['product_id'],
        quantity = json['quantity'],
        name = json['name'],
        total = json['total'],
        variationId = json['variation_id'];

  Map<String, dynamic> toJson() {
    return {'product_id': productId, 'quantity': quantity, 'variation_id': variationId};
  }
}
