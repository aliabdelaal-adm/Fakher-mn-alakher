import 'dart:async';
import 'package:app/src/data_layer/models/product.dart';
import 'package:app/src/data_layer/repositories/category_repository.dart';
import 'package:rxdart/rxdart.dart';

class SearchBloc {
  CategoryRepository _repository = CategoryRepository();

  final _productFetcher = BehaviorSubject<List<Product>>();

  Stream<List<Product>> get searchedProducts => _productFetcher.stream;

  searchProducts(String keyword) async {

    List<Product> productsResponse =
        await _repository.searchProducts(keyword: keyword);
    _productFetcher.sink.add(productsResponse);
  }

  clear() {
    _productFetcher.sink.add(null);
  }

  dispose() {
    _productFetcher.close();
  }
}

final searchBloc = SearchBloc();
