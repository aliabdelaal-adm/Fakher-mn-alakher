import 'dart:async';
import 'package:app/src/data_layer/models/variation.dart';
import 'package:app/src/data_layer/repositories/category_repository.dart';
import 'package:rxdart/rxdart.dart';

class VariationBloc {
  CategoryRepository _repository = CategoryRepository();

  final _variationFetcher = BehaviorSubject<List<Variation>>();

  Stream<List<Variation>> get variations => _variationFetcher.stream;

  fetchVariations(String productId) async {
    List<Variation> variationResponse = await _repository.fetchVariations(productId: productId);
    _variationFetcher.sink.add(variationResponse);
  }

  clear() {
    _variationFetcher.sink.add(null);
  }

  dispose() {
    _variationFetcher.close();
  }
}

final variationFetchBloc = VariationBloc();
