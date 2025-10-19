import 'dart:async';
import 'package:app/src/data_layer/models/order.dart';
import 'package:rxdart/rxdart.dart';
import '../data_layer/repositories/order-repository.dart';

class OrderBloc {
  OrderRepository _orderRepository = OrderRepository();

  Future<Order> submitOrder(order) => _orderRepository.submitOrder(order);

  Future<Order> updateOrder(Order order, String status) =>
      _orderRepository.updateOrder(order, status);

  Future<Order> updateOrderToPaid(Order order) =>
      _orderRepository.updateOrderToPaid(order);

  submitOrderNote(Order order, String note) =>
      _orderRepository.submitOrderNote(order, note);

  final _ordersFetcher = BehaviorSubject<List<Order>>();

  Stream<List<Order>> get orders => _ordersFetcher.stream;

  fetchCustomerOrders(int customerId) async {
    List<Order> ordersResponse =
        await _orderRepository.getCustomerOrders(customerId);
    _ordersFetcher.sink.add(ordersResponse);
  }

  dispose() {
    _ordersFetcher.close();
  }
}

final orderBloc = OrderBloc();
