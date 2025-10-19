import 'package:app/src/data_layer/models/customer.dart';
import 'package:app/src/data_layer/repositories/customer_repository.dart';

class CustomerBloc {
  CustomerRepository _customerRepository = CustomerRepository();

  Future<Customer> login(customer) => _customerRepository.login(customer);

  Future<Customer> signUp(customer) => _customerRepository.signUp(customer);

  saveCustomer(customer) => _customerRepository.saveCustomer(customer);

  getSavedCustomer() => _customerRepository.getSavedCustomer();

  logout() => _customerRepository.logout();
}

final customerBloc = CustomerBloc();
