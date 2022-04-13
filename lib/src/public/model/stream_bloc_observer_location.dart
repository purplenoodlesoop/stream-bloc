import 'package:stream_bloc/src/public/base/stream_bloc_observer.dart';

/// A sum-type that represents possible locations for injected
/// [StreamBlocObserver]s.
///
/// - [zone]-located observer is injected through the
/// [StreamBlocObserver.inject]
/// - static-located observer is injected through the
/// [StreamBlocObserver.current] or [StreamBlocObserver.config].
enum StreamBlocObserverLocation {
  /// Injected through the [StreamBlocObserver.inject]
  zone,

  /// Injected through the [StreamBlocObserver.current] or
  /// [StreamBlocObserver.config].
  static,
}

extension StreamBlocObserverLocationX on StreamBlocObserverLocation {
  /// Performs a pattern-matching on this location as a less-verbose alternative
  /// to the switch-case.
  R when<R>({
    required R Function() zone,
    required R Function() static,
  }) {
    switch (this) {
      case StreamBlocObserverLocation.zone:
        return zone();
      case StreamBlocObserverLocation.static:
        return static();
    }
  }

  /// Returns the opposite location.
  StreamBlocObserverLocation get opposite => when(
        zone: () => StreamBlocObserverLocation.static,
        static: () => StreamBlocObserverLocation.zone,
      );
}
