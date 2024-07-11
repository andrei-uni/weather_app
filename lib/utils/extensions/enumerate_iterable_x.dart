extension EnumerateIterableX<T> on Iterable<T> {
  Iterable<(T item, int index)> enumerate() sync* {
    int i = 0;
    for (final T item in this) {
      yield (item, i++);
    }
  }
}
