import 'dart:async';
import 'package:app/src/data_layer/models/wallet-response.dart';
import 'package:app/src/data_layer/repositories/wallet_repository.dart';
import 'package:rxdart/rxdart.dart';

class WalletBloc {
  WalletRepository _walletRepository = WalletRepository();

  String walletBalance ;

  Future<WalletResponse> credit(customerId, amount) =>
      _walletRepository.credit(customerId, amount);

  Future<WalletResponse> debit(customerId, amount) =>
      _walletRepository.debit(customerId, amount);

  final _walletBalanceFetcher = BehaviorSubject<String>();

  Stream<String> get walletBalanceStream => _walletBalanceFetcher.stream;

  fetchWalletBalance(int customerId) async {
    String walletResponse =
        await _walletRepository.getCustomerWalletBalance(customerId);
    walletBalance = walletResponse.replaceAll('"', " ");
    _walletBalanceFetcher.sink.add(walletBalance);
  }

  dispose() {
    _walletBalanceFetcher.close();
  }
}

final walletBloc = WalletBloc();
