import 'package:app/src/data_layer/models/address.dart';
import 'package:app/src/data_layer/models/deilvery-time.dart';
import 'package:app/src/data_layer/models/times.dart';
import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';

ValueNotifier<Address> currentAddress = new ValueNotifier(Address());
ValueNotifier<List<Address>> currentAddresses =
    new ValueNotifier(<Address>[]);
ValueNotifier<DeliveryTime> selectedDeliveryTime =
    new ValueNotifier(DeliveryTime("null", false));
ValueNotifier<Time> selectedTime = new ValueNotifier(Time());
ValueNotifier<String> selectedPayment = new ValueNotifier("Select your payment method");

class DeliveryRepository {

  saveAddress(address) async {
    print("save delivery_address");
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<Address> addresses;
    if (prefs.containsKey('delivery_address')) {
      addresses = Address.decodeAddresses(prefs.getString('delivery_address'));
      addresses.add(address);
      print(addresses.first.address);
      print(addresses.last.address);
    } else {
      addresses = <Address>[];
      addresses.add(address);
    }
    prefs.setString('delivery_address', Address.encodeAddresses(addresses));
    print(addresses.length);
    currentAddresses.value = addresses;
  }

  Future<List<Address>> getSavedAddresses() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
//    prefs.clear();
    if (prefs.containsKey('delivery_address')) {
      currentAddresses.value =
          Address.decodeAddresses(prefs.getString('delivery_address'));
    }
    return currentAddresses.value;
  }


}
