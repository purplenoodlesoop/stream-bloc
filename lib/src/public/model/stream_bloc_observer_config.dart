import 'package:meta/meta.dart';
import 'package:stream_bloc/src/public/base/stream_bloc_observer.dart';
import 'package:stream_bloc/src/public/model/stream_bloc_observer_priority.dart';

@immutable
class StreamBlocObserverConfig {
  final StreamBlocObserver? observer;
  final StreamBlocObserverPriority observerPriority;
  final bool shouldFallback;

  const StreamBlocObserverConfig({
    this.observer,
    this.observerPriority = StreamBlocObserverPriority.zone,
    this.shouldFallback = true,
  });

  StreamBlocObserverConfig copyWith({
    StreamBlocObserver? observer,
    StreamBlocObserverPriority? observerPriority,
    bool? shouldFallback,
  }) =>
      StreamBlocObserverConfig(
        observer: observer ?? this.observer,
        observerPriority: observerPriority ?? this.observerPriority,
        shouldFallback: shouldFallback ?? this.shouldFallback,
      );

  @override
  String toString() => 'StreamBlocObserverConfig(observer: $observer, '
      'observerPriority: $observerPriority, '
      'shouldFallback: $shouldFallback)';

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is StreamBlocObserverConfig &&
          observer == other.observer &&
          observerPriority == other.observerPriority &&
          shouldFallback == other.shouldFallback);

  @override
  int get hashCode =>
      observer.hashCode ^ observerPriority.hashCode ^ shouldFallback.hashCode;
}
