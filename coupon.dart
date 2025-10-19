class Coupon {
  int id;
  String code;
  String type;
  String amount;
  String expiryDate;
  bool enableFreeShipping;
  String minimumAmount;
  String maximumAmount;

  Coupon();

  Coupon.fromJson(json)

      : id = json['id'],
        code = json['code'],
        type = json['type'],
        amount = json['amount'],
        expiryDate = json['expiry_date'],
        enableFreeShipping = json['enable_free_shipping'],
        minimumAmount = json['minimum_amount'],
        maximumAmount = json['maximum_amount'];
}
