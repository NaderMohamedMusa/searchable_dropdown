/// Offset paging for [SearchableDropdown.asyncItems].
///
/// Use [skip] and [take] for APIs that take offset/limit.
/// This is useful when you need a page counter derived from the same values.
class LoadProps {
  final int skip;
  final int take;

  const LoadProps({
    this.skip = 0,
    this.take = 10,
  })  : assert(skip >= 0),
        assert(take > 0);

  /// 0-based page index from offset paging: `skip ~/ take`.
  ///
  /// When each response returns exactly [take] rows, [skip ~/ take]
  /// counts 0, 1, 2, ... If [skip] is not aligned (e.g. variable
  /// skip / take (same chunk as offset/limit APIs).
  int get pageIndex => skip ~/ take;

  /// 1-based page label for APIs that use `page=1,2,...`.
  int get pageNumber => pageIndex + 1;

  LoadProps copyWith({
    int? skip,
    int? take,
  }) {
    return LoadProps(
      skip: skip ?? this.skip,
      take: take ?? this.take,
    );
  }
}