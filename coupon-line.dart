class CouponLine {
//  int id;
  String code;
//  String amount;

  CouponLine(this.code);

  CouponLine.fromJson(Map json)
//      : id = json['id'],
        : code = json['code'];
//        amount = json['amount'];

  Map<String, dynamic> toJson() {
    return {'code': code};
  }
}
