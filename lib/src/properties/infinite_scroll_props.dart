import 'load_props.dart';
import '../utils/typedef_data_type.dart' show InfiniteScrollBuilder;

class InfiniteScrollProps {
  final LoadProps loadProps;
  final InfiniteScrollBuilder? loadingMoreBuilder;

  const InfiniteScrollProps({
    this.loadingMoreBuilder,
    this.loadProps = const LoadProps(),
  });
}