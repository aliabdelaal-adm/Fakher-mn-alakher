import 'dart:async';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'l10n/messages_all.dart';

class AppLocalizations {
  static Future<AppLocalizations> load(Locale locale) {
    final String name =
        locale.countryCode == null ? locale.languageCode : locale.toString();
    final String localeName = Intl.canonicalizedLocale(name);

    return initializeMessages(localeName).then((bool _) {
      Intl.defaultLocale = localeName;
      return new AppLocalizations();
    });
  }

  static AppLocalizations of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  String get title {
    return Intl.message('Hello world App',
        name: 'title', desc: 'The application title');
  }

  String get delivery_address {
    return Intl.message('Delivery address', name: 'delivery_address');
  }

  String get add_delivery_address {
    return Intl.message('Add delivery address', name: 'add_delivery_address');
  }

  String get add_new_delivery_address {
    return Intl.message('Add new delivery address',
        name: 'add_new_delivery_address');
  }

  String get select_delivery_time {
    return Intl.message('Select delivery time', name: 'select_delivery_time');
  }

  String get delivery_time {
    return Intl.message('Delivery time', name: 'delivery_time');
  }

  String get payment_mode {
    return Intl.message('Payment method', name: 'payment_mode');
  }

  String get select_your_preferred_payment_mode {
    return Intl.message('Select your preferred payment method',
        name: 'select_your_preferred_payment_mode');
  }

  String get package {
    return Intl.message('Package', name: 'package');
  }

  String get free {
    return Intl.message('Free', name: 'free');
  }

  String get discount {
    return Intl.message('Discount', name: 'discount');
  }

  String get discount2 {
    return Intl.message('Discount', name: 'discount2');
  }

  String get exclusive_offer {
    return Intl.message('Exclusive', name: 'exclusive_offer');
  }

  String get competition {
    return Intl.message('Competition', name: 'competition');
  }

  String get bucket {
    return Intl.message('Bucket', name: 'bucket');
  }

  String get add_coupon {
    return Intl.message('Add Coupon', name: 'add_coupon');
  }

  String get out_of_stock {
    return Intl.message('Out Of Stock', name: 'out_of_stock');
  }

  String get bottle {
    return Intl.message('Bottle', name: 'bottle');
  }

  String get send_to_bank_account {
    return Intl.message(
        'Transfer the required amount by copying the bank account below',
        name: 'send_to_bank_account');
  }

  String get barrel {
    return Intl.message('Barrel', name: 'barrel');
  }

  String get on_back_order {
    return Intl.message('On Back Order', name: 'on_back_order');
  }

  String get total {
    return Intl.message('Total', name: 'total');
  }

  String get total_amount {
    return Intl.message('Total Amount', name: 'total_amount');
  }

  String get name {
    return Intl.message('Name', name: 'name');
  }

  String get password {
    return Intl.message('Password', name: 'password');
  }

  String get phone {
    return Intl.message(
      'Phone',
      name: 'phone',
      desc: '',
      args: [],
    );
  }

  String get sign_up {
    return Intl.message('Sign Up', name: 'sign_up');
  }

  String get login {
    return Intl.message('Login', name: 'login');
  }

  String get have_account {
    return Intl.message('Already have account', name: 'have_account');
  }

  String get forgot_password {
    return Intl.message('Forgot Your Password', name: 'forgot_password');
  }

  String get dont_have_an_account {
    return Intl.message('Dont have an account', name: 'dont_have_an_account');
  }

  String get cash_on_delivery {
    return Intl.message('Cash on Delivery', name: 'cash_on_delivery');
  }

  String get bank_transfer {
    return Intl.message('Bank Transfer', name: 'bank_transfer');
  }

  String get tax {
    return Intl.message('Tax', name: 'tax');
  }

  String get delivery_fee {
    return Intl.message('Delivery Fee', name: 'delivery_fee');
  }

  String get note {
    return Intl.message('Notes', name: 'note');
  }

  String get not_a_valid_full_name {
    return Intl.message('Not a valid full name', name: 'not_a_valid_full_name');
  }

  String get not_a_valid_phone {
    return Intl.message('Not a valid phone', name: 'not_a_valid_phone');
  }

  String get password_must_be_greater {
    return Intl.message('Password must be greater than 2 characters',
        name: 'password_must_be_greater');
  }

  String get dont_have_any_item_in_your_cart {
    return Intl.message("You haven't taken any item yet",
        name: 'dont_have_any_item_in_your_cart');
  }

  String get submit_order {
    return Intl.message("Submit order", name: 'submit_order');
  }

  String get wrong_phone_or_password {
    return Intl.message("Wrong phone or password",
        name: 'wrong_phone_or_password');
  }

  String get enter_phone_number_verification {
    return Intl.message("Enter phone number verification",
        name: 'enter_phone_number_verification');
  }

  String get verification {
    return Intl.message("Verification", name: 'verification');
  }

  String get verify {
    return Intl.message("Verify", name: 'verify');
  }

  String get invalid_verification_code {
    return Intl.message("Invalid verification code",
        name: 'invalid_verification_code');
  }

  String get welcome {
    return Intl.message("Welcome", name: 'welcome');
  }

  String get problem_while_verifying_code {
    return Intl.message("Problem occurred while verifying your number",
        name: 'problem_while_verifying_code');
  }

  String get problem_occurred {
    return Intl.message("Problem occurred, please try again",
        name: 'problem_occurred');
  }

  String get your_order_has_been_successfully_submitted {
    return Intl.message("your order has been successfully submitted",
        name: 'your_order_has_been_successfully_submitted');
  }

  String get thanks_for_ordering {
    return Intl.message("Thank you for your order with Fresh",
        name: 'thanks_for_ordering');
  }

  String get tracking_order {
    return Intl.message("Track your order", name: 'tracking_order');
  }

  String get order_received {
    return Intl.message("Order Recieved", name: 'order_received');
  }

  String get preparing {
    return Intl.message("Preparing", name: 'preparing');
  }

  String get ready {
    return Intl.message("Ready", name: 'ready');
  }

  String get on_the_way {
    return Intl.message("On the way", name: 'on_the_way');
  }

  String get delivered {
    return Intl.message("Delivered", name: 'delivered');
  }

  String get update {
    return Intl.message("Update", name: 'update');
  }

  String get what_is_the_cost_of_delivery_fee {
    return Intl.message("what_is_the_cost_of_delivery_fee",
        name: 'what_is_the_cost_of_delivery_fee');
  }

  String get what_is_the_min_amount {
    return Intl.message("what_is_the_min_amount",
        name: 'what_is_the_min_amount');
  }

  String get how_i_can_order {
    return Intl.message("how_i_can_order", name: 'how_i_can_order');
  }

  String get how_i_can_contact_you {
    return Intl.message("how_i_can_contact_you", name: 'how_i_can_contact_you');
  }

  String get delivery_fee_cost_is {
    return Intl.message("delivery_fee_cost_is", name: 'delivery_fee_cost_is');
  }

  String get min_amount_is {
    return Intl.message("min_amount_is", name: 'min_amount_is');
  }

  String get you_can_order_using {
    return Intl.message("you_can_order_using", name: 'you_can_order_using');
  }

  String get you_can_contact_using {
    return Intl.message("you_can_contact_using", name: 'you_can_contact_using');
  }

  String get faq {
    return Intl.message("FAQ", name: 'faq');
  }

  String get my_orders {
    return Intl.message("My Orders", name: 'my_orders');
  }

  String get order_number {
    return Intl.message("Order num", name: 'order_number');
  }

  String get currency {
    return Intl.message("currency", name: 'currency');
  }

  String get profile {
    return Intl.message("My Profile", name: 'profile');
  }

  String get add_to_cart {
    return Intl.message("Add to cart", name: 'add_to_cart');
  }

  String get app_language {
    return Intl.message("App Language", name: 'app_language');
  }

  String get language {
    return Intl.message("Language", name: 'language');
  }

  String get delivery_addresses {
    return Intl.message("Delivery Addresses", name: 'delivery_addresses');
  }

  String get this_phone_exists {
    return Intl.message("Phone already used", name: 'this_phone_exists');
  }

  String get kilo {
    return Intl.message("Kilo", name: 'kilo');
  }

  String get piece {
    return Intl.message("Piece", name: 'piece');
  }

  String get piece2 {
    return Intl.message("Piece", name: 'piece2');
  }

  String get packet {
    return Intl.message("Packet", name: 'packet');
  }

  String get gram {
    return Intl.message("Gram", name: 'gram');
  }

  String get box {
    return Intl.message("Box", name: 'box');
  }

  String get bag {
    return Intl.message("Bag", name: 'bag');
  }

  String get dish {
    return Intl.message("Dish", name: 'dish');
  }

  String get pack {
    return Intl.message("Pack", name: 'pack');
  }

  String get dont_have_any_order {
    return Intl.message("You don't have any order",
        name: 'dont_have_any_order');
  }

  String get logout {
    return Intl.message("Logout", name: 'logout');
  }

  String get order_is_less_than {
    return Intl.message("order_is_less_than", name: 'order_is_less_than');
  }

  String get expired_coupon {
    return Intl.message("expired_coupon", name: 'expired_coupon');
  }

  String get verified_coupon {
    return Intl.message("verified_coupon", name: 'verified_coupon');
  }

  String get invalid_coupon {
    return Intl.message("invalid_coupon", name: 'invalid_coupon');
  }

  String get order_amount_should_more_than {
    return Intl.message("order_amount_should_more_than",
        name: 'order_amount_should_more_than');
  }

  String get discount_deleted_becasue_amount_is_less_than {
    return Intl.message("discount_deleted_becasue_amount_is_less_than",
        name: 'discount_deleted_becasue_amount_is_less_than');
  }

  String get help_supports {
    return Intl.message("help_supports", name: 'help_supports');
  }

  String get home {
    return Intl.message("home", name: 'home');
  }

  String get tapAgainToLeave {
    return Intl.message("tapAgainToLeave", name: 'tapAgainToLeave');
  }

  String get did_not_receive_the_code {
    return Intl.message("did_not_receive_the_code",
        name: 'did_not_receive_the_code');
  }

  String get resend {
    return Intl.message("resend", name: 'resend');
  }

  String get credit_card {
    return Intl.message("credit_card", name: 'credit_card');
  }

  String get wallet_balance {
    return Intl.message("wallet_balance", name: 'wallet_balance');
  }

  String get wallet {
    return Intl.message("wallet", name: 'wallet');
  }

  String get no_enough_credit_on_wallet {
    return Intl.message("no_enough_credit_on_wallet",
        name: 'no_enough_credit_on_wallet');
  }

  String get shopping_cart {
    return Intl.message("shopping_cart", name: 'shopping_cart');
  }

  String get congrats_cash_back {
    return Intl.message("congrats_cash_back", name: 'congrats_cash_back');
  }

  String get in_your_wallet {
    return Intl.message("in_your_wallet", name: 'in_your_wallet');
  }

  String get no_result_found {
    return Intl.message("404 - No Results Found", name: 'no_result_found');
  }

  String get search {
    return Intl.message("Search", name: 'search');
  }

  String get rate {
    return Intl.message("Rate", name: 'rate');
  }

  String get rate_now {
    return Intl.message("Rate Now", name: 'rate_now');
  }

  String get thanks_for_reviewing {
    return Intl.message("Thanks for reviewing ", name: 'thanks_for_reviewing');
  }

  String get product_rating {
    return Intl.message("product_rating", name: 'product_rating');
  }

  String get free_delivery {
    return Intl.message("free_delivery", name: 'free_delivery');
  }

  String get save_m {
    return Intl.message("save_m", name: 'save_m');
  }

  String get order_now {
    return Intl.message("order_now", name: 'order_now');
  }

  String get limited_quantity {
    return Intl.message("limited_quantity", name: 'limited_quantity');
  }

  String get less_price {
    return Intl.message("less_price", name: 'less_price');
  }

  String get sold_out {
    return Intl.message("sold_out", name: 'sold_out');
  }

  String get new_product {
    return Intl.message("new_product", name: 'new_product');
  }

  String get hurry_up_to_order {
    return Intl.message("hurry_up_to_order", name: 'hurry_up_to_order');
  }

  String get to_participate {
    return Intl.message("to_participate", name: 'to_participate');
  }

// discount,free_delivery,save_m, order_now,limited_quantity, less_price ,sold_out, new_product,hurry_up_to_order, to_participate

}

class AppLocalizationsDelegate extends LocalizationsDelegate<AppLocalizations> {
  const AppLocalizationsDelegate();

  @override
  bool isSupported(Locale locale) {
    return ['en', 'ar'].contains(locale.languageCode);
  }

  @override
  Future<AppLocalizations> load(Locale locale) {
    return AppLocalizations.load(locale);
  }

  @override
  bool shouldReload(LocalizationsDelegate<AppLocalizations> old) {
    return false;
  }
}
