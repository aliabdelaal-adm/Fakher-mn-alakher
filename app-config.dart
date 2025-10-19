import 'package:app/src/common/helper.dart';
import 'package:app/src/data_layer/models/carousel.dart';
import 'package:app/src/data_layer/models/social.dart';
import 'deilvery-time.dart';
import 'faq.dart';

class AppConfig {
  final String vat;
  final String deliveryFee;
  final bool phoneVerificationEnabled;
  final List<DeliveryTime> timesArray;
  final List<Faq> faqArray;
  final List<CarouselItem> carouselItemsArray;
  final List<Social> socialArray;
  final String whatsApp;
  final String supportNumber;
  final String minAllowedAmount;
  final bool tapPaymentEnabled;
  final bool carouselEnabled;
  final bool codEnabled;
  final bool walletEnabled;
  final bool liveChatEnabled;
  final String liveChatId;
  final String liveChatGroup;
  final bool bankTransferEnabled;
  final String bankIBAN;
  final String bankName;
  final String cashBackAmount;
  final String testingCountry;

  AppConfig.fromJson(json)
      : vat = json['vat'],
        deliveryFee = json['delivery_fee'],
        phoneVerificationEnabled = json['phone_verification_enabled'],
        whatsApp = json['whatsapp'],
        supportNumber = json['support_number'],
        minAllowedAmount = json['min_allowed_amount'],
        tapPaymentEnabled = json['tap_payment_enabled'],
        carouselEnabled =
            json['carousel_enabled'] != null ? json['carousel_enabled'] : false,
        codEnabled = json['cod_enabled'],
        walletEnabled = json['wallet_enabled'],
        bankTransferEnabled = json['bank_transfer_enabled'],
        liveChatEnabled = json['live_chat_enabled'],
        liveChatGroup = json['live_chat_group'],
        liveChatId = json['live_chat_id'],
        bankIBAN = json['bank_iban'],
        bankName = json['bank_name'],
        cashBackAmount = json['cash_back_amount'],
        socialArray = (json['social'] as List)
            .map((item) => Social.fromJson(item))
            .toList(),
        testingCountry =
            json['testing_country'] != null ? json['testing_country'] : "",
        faqArray =
            (json['faq'] as List).map((item) => Faq.fromJson(item)).toList(),
        carouselItemsArray = (json['carousel_items'] as List)
            .map((item) => CarouselItem.fromJson(item))
            .toList(),
        timesArray = Helper.getUpComingSevenDays((json['times_array'] as List)
            .map((item) => DeliveryTime.fromJson(item))
            .toList());
}
