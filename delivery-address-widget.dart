import 'package:app/src/bloc/delivery-bloc.dart';
import 'package:app/src/data_layer/models/address.dart';
import 'package:app/src/data_layer/repositories/delivery-repository.dart';
import 'package:app/src/theme/colors.dart';
import 'package:flutter/material.dart';
import 'package:google_map_location_picker/google_map_location_picker.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import '../../../localizations.dart';

class DeliveryAddressWidget extends StatefulWidget {
  @override
  _DeliveryAddressWidgetState createState() => _DeliveryAddressWidgetState();
}

class _DeliveryAddressWidgetState extends State<DeliveryAddressWidget> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        _showDeliveryAddressSheet(context);
      },
      child: Container(
        width: double.infinity,
        decoration: BoxDecoration(boxShadow: [
          BoxShadow(
            color: Colors.blue.withOpacity(0.1),
            spreadRadius: 1,
            blurRadius: 1,
            offset: Offset(0, 1),
          ),
        ]),
        child: Card(
          color: Colors.white,
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: const BorderRadius.all(
              Radius.circular(5.0),
            ),
          ),
          child: Column(
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      AppLocalizations.of(context).delivery_address,
                      style: TextStyle(
                          fontSize: 14,
                          color: Color(0xFF3a3a3b),
                          fontWeight: FontWeight.w600),
                      textAlign: TextAlign.left,
                    ),
                  )
                ],
              ),
              Row(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      // width: 300,
                      child: currentAddress.value.address != null
                          ? selectedItem(currentAddress.value.address.length >
                                  40
                              ? currentAddress.value.address.substring(0, 40)
                              : currentAddress.value.address)
                          : Text(
                              AppLocalizations.of(context).add_delivery_address,
                              style: TextStyle(
                                  color: Colors.red,
                                  fontSize: 10,
                                  fontWeight: FontWeight.w600),
                              textAlign: TextAlign.left,
                              overflow: TextOverflow.ellipsis,
                            ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _showDeliveryAddressSheet(context) {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext bc) {
          return Container(
            child: new Wrap(
                children: _buildResult(currentAddresses.value, context)),
          );
        });
  }

  Widget selectedItem(String selectedAddress) {
    return Container(
      constraints: BoxConstraints(maxWidth: 300),
      decoration: BoxDecoration(
          // color: Colors.green[50],
          borderRadius: BorderRadius.circular(6.0)),
      child: Row(
        children: [
        Text(
          selectedAddress,
        style: TextStyle(
            color: Colors.black, fontSize: 10, fontWeight: FontWeight.w600),
        textAlign: TextAlign.left,
      ),
          Spacer(),
          Icon(
            Icons.check_circle_rounded,
            color: shadowColor,
          ),
        ],
      ),
    );
  }

  _buildResult(List<Address> addresses, context) {
    List<Widget> widgets = <Widget>[];

    widgets.add(
      new ListTile(
          title:
              new Text(AppLocalizations.of(context).add_new_delivery_address),
          onTap: () async {
            Navigator.pop(context);
            LocationResult result = await showLocationPicker(
              context, 'AIzaSyB9NkUPOoFSYTU2dAs2oX8wtMDBpcwBvSo',
              initialCenter: LatLng(24.554324015254117, 54.45278685539961),
              automaticallyAnimateToCurrentLocation: true,
//                      mapStylePath: 'assets/mapStyle.json',
              myLocationButtonEnabled: true,
//               requiredGPS: true,
              layersButtonEnabled: true,
              countries: ['SA','AE','KW','OM','QA','BH','EG'],
              language: 'ar',
              resultCardAlignment: Alignment.bottomCenter,
              desiredAccuracy: LocationAccuracy.best,
            );
            var address = new Address.fromJson({
              'address': result.address,
              'latitude': result.latLng.latitude,
              'longitude': result.latLng.longitude,
            });
            deliveryBloc.saveAddress(address);
            print(result.latLng.latitude);
            print(result.latLng.longitude);

            setState(() => currentAddress.value = address);
          }),
    );
    if (addresses != null) {
      for (var address in addresses) {
        widgets.add(
          new ListTile(
              title: new Text(address.address),
              onTap: () => {
                    setState(() {
                      currentAddress.value = address;
                      Navigator.pop(context);
                    })
                  }),
        );
      }
    }

    return widgets;
  }
}
