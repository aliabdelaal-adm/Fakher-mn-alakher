import 'package:app/src/data_layer/repositories/delivery-repository.dart';

class DeliveryBloc {
  DeliveryRepository _deliveryRepository = DeliveryRepository();

  saveAddress(address) => _deliveryRepository.saveAddress(address);

  getSavedAddresses() => _deliveryRepository.getSavedAddresses();
}

final deliveryBloc = DeliveryBloc();
