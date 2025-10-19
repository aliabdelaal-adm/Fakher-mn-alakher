import 'package:app/src/data_layer/models/category.dart';
import 'package:app/src/data_layer/repositories/category_repository.dart';
import 'package:rxdart/rxdart.dart';

class CategoriesFetchBloc {
  CategoryRepository _repository = CategoryRepository();
  final _categoryFetcher = BehaviorSubject<List<Category>>();

  Stream<List<Category>> get categories => _categoryFetcher.stream;

  fetchCategories() async {
    List<Category> categoriesResponse = await _repository.fetchCategories();
    _categoryFetcher.sink.add(categoriesResponse);
  }

  dispose() {
    _categoryFetcher.close();
  }

}
final categoriesFetchBloc = CategoriesFetchBloc();
