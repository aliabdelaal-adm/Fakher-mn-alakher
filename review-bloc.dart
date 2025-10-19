import 'dart:async';
import 'package:app/src/data_layer/models/product.dart';
import 'package:app/src/data_layer/repositories/category_repository.dart';

class ReviewBloc {
  CategoryRepository _categoryRepository = CategoryRepository();

  Future<Product> submitReview(product, customer) =>
      _categoryRepository.submitReview(product,customer);
}

final reviewBloc = ReviewBloc();
