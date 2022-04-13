import 'package:meta/meta.dart';
import 'package:stream_bloc/src/public/base/stream_bloc_observer.dart';
import 'package:stream_bloc/src/public/model/stream_bloc_observer_location.dart';

/// {@template stream_bloc_observer_config.StreamBlocObserverConfig}
/// Class that represents a global, immutable configuration for
/// [StreamBlocObserver].
///
/// Controls three main aspects of it injection and location.
///   1) [observer] - the [StreamBlocObserver] instance that will be used for
/// all [StreamBlocObserver]s at a [StreamBlocObserverLocation.static] location.
///   2) [prioritizedLocation] - the [StreamBlocObserverLocation] that will be
/// looked up first when looking for an [StreamBlocObserver] instance.
///   3) [shouldFallback] - whether to fallback to the opposite
/// [StreamBlocObserverLocation] when the [observer] is null or not.
/// {@endtemplate}
@immutable
class StreamBlocObserverConfig {
  /// The current observer that will be used at
  /// [StreamBlocObserverLocation.static] location
  final StreamBlocObserver? observer;

  /// The prioritized location that will be looked at firstly if
  /// [shouldFallback] is set to `true` or only at if set to `false`.
  final StreamBlocObserverLocation prioritizedLocation;

  /// Whether to fallback to the opposite location if the current location is
  /// not present or not.
  final bool shouldFallback;

  /// {@macro stream_bloc_observer_config.StreamBlocObserverConfig}
  const StreamBlocObserverConfig({
    this.observer,
    this.prioritizedLocation = StreamBlocObserverLocation.zone,
    this.shouldFallback = true,
  });

  /// Creates a copy of this config with updated values that were passed in as
  /// an arguments to this method.
  StreamBlocObserverConfig copyWith({
    StreamBlocObserver? observer,
    StreamBlocObserverLocation? prioritizedLocation,
    bool? shouldFallback,
  }) =>
      StreamBlocObserverConfig(
        observer: observer ?? this.observer,
        prioritizedLocation: prioritizedLocation ?? this.prioritizedLocation,
        shouldFallback: shouldFallback ?? this.shouldFallback,
      );

  @override
  String toString() => 'StreamBlocObserverConfig(observer: $observer, '
      'observerPriority: $prioritizedLocation, '
      'shouldFallback: $shouldFallback)';

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is StreamBlocObserverConfig &&
          observer == other.observer &&
          prioritizedLocation == other.prioritizedLocation &&
          shouldFallback == other.shouldFallback);

  @override
  int get hashCode =>
      observer.hashCode ^
      prioritizedLocation.hashCode ^
      shouldFallback.hashCode;
}
