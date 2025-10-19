class ShippingLine {
  String methodId;
  String methodTitle;
  String total;

  ShippingLine(this.methodId, this.methodTitle, this.total);

  ShippingLine.fromJson(Map json)
      : methodId = json['method_id'],
        methodTitle = json['method_title'],
        total = json['total'];

  Map<String, dynamic> toJson() {
    return {'method_id': methodId, 'method_title': methodTitle, 'total': total};
  }
}