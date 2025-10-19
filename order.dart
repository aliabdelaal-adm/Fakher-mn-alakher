import 'billing_data.dart';
import 'coupon-line.dart';
import 'line-item.dart';
import 'line-shipping.dart';
import 'order-meta_data.dart';

class Order {

  static const STATUS_COMPLETED = "completed";
  static const STATUS_PENDING = "pending";
  static const STATUS_ON_THE_WAY = "on_the_way";
  static const STATUS_DELIVERED = "delivered";
  static const STATUS_PROCESSING = "processing";


  int id;
  String paymentMethod;
  String status;
  String currency;
  String dateCreated;
  String dateModified;
  String dateCompleted;
  bool setPaid;
  int customerId;
  List<LineItem> lineItems;
  List<OrderMetaData> metaData;
  List<CouponLine> couponLines;
  List<ShippingLine> shippingLines;
  Billing billingData;
  String customerNote;
  bool isExpanded = false;
  String total;
  String totalTax;
  String shippingTotal;

  Order(
      this.paymentMethod,
      this.setPaid,
      this.customerId,
      this.lineItems,
      this.metaData,
      this.customerNote,
      this.couponLines,
      this.shippingLines,
      this.billingData);

  Order.fromJson(Map json)
      : id = json['id'],
        status = json['status'],
        currency = json['currency'],
        dateCreated = json['date_created'],
        dateModified = json['date_modified'],
        dateCompleted = json['date_completed'],
        paymentMethod = json['payment_method'],
        customerId = json['customer_id'],
        metaData = getMetaData(json),
        customerNote = json['customer_note'],
        total = json['total'],
        billingData = getBillingData(json),
        lineItems = getLineItems(json),
        totalTax = json['total_tax'],
        shippingTotal = json['shipping_total'];

  static getMetaData(json) {
    var metaDataJson = json['meta_data'] as List;
    List<OrderMetaData> metaData = metaDataJson
        .map((metaJson) => OrderMetaData.fromJson(metaJson))
        .toList();
    return metaData;
  }

  static getLineItems(json) {
    var lineItemsJson = json['line_items'] as List;
    List<LineItem> metaData = lineItemsJson
        .map((metaJson) => LineItem.fromJson(metaJson))
        .toList();
    return metaData;
  }

  static getBillingData(json) {
        return Billing.fromJson(json['billing']);
  }

}
