class Result<E, T> {
  final T? _data;
  final E? _failure;

  Result.success(this._data) : _failure = null;

  Result.failure(this._failure) : _data = null;

  bool get isSuccess => _data != null;

  T? get data => _data;

  E? get error => _failure;

  void when({
    required Function(T) success,
    required Function(E) failure,
  }) {
    if (_data != null) {
      success(_data as T);
    } else if (_failure != null) {
      failure(_failure);
    }
  }

  @override
  bool operator ==(covariant Result<E, T> other) {
    if (identical(this, other)) return true;

    return other._data == _data && other._failure == _failure;
  }

  @override
  int get hashCode => _data.hashCode ^ _failure.hashCode;
}
