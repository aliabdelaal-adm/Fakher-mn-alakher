import 'dart:async';
import 'package:app/src/data_layer/models/product.dart';
import 'package:app/src/data_layer/repositories/category_repository.dart';
import 'package:rxdart/rxdart.dart';

class ProductsFetchBloc {
  CategoryRepository _repository = CategoryRepository();

  final _productFetcher = BehaviorSubject<List<Product>>();

  Stream<List<Product>> get products => _productFetcher.stream;

  final Map<String, List<Product>> categoriesAndProducts = new Map();

  fetchProducts(String categoryId) async {

    if (categoriesAndProducts.containsKey(categoryId)) {
      print("getting category products for id " + categoryId + " from memory");
      _productFetcher.sink.add(categoriesAndProducts[categoryId]);
    } else {
      print("getting category products for id " + categoryId + " from api");
      List<Product> productsResponse =
          await _repository.fetchProducts(categoryId: categoryId);
      categoriesAndProducts[categoryId] = productsResponse;
      _productFetcher.sink.add(productsResponse);
    }
  }

  clear() {
    _productFetcher.sink.add(null);
  }

  dispose() {
    _productFetcher.close();
  }
}

final productsFetchBloc = ProductsFetchBloc();
