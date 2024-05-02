import '../../domain/errors/category_error.dart';

class CategoryErrorImpl extends CategoryError {
  CategoryErrorImpl({
    super.title = '',
    super.message = '',
    super.id = 0,
  });

  factory CategoryErrorImpl.defaultError() {
    return CategoryErrorImpl(
      id: -1,
    );
  }
}
