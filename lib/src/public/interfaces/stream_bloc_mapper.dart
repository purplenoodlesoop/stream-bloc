import 'package:meta/meta.dart';

abstract class StreamBlocMapper<Event extends Object?, State extends Object?> {
  /// Whether the bloc is closed.
  ///
  /// A bloc is considered closed once [close] is called.
  /// Subsequent state changes cannot occur within a closed bloc.
  bool get isClosed;

  /// Must be implemented when a class extends [IStreamBloc].
  /// [mapEventToStates] is called whenever an [event] is [add]ed
  /// and is responsible for converting that [event] into a new [state].
  /// [mapEventToStates] can `yield` zero, one, or multiple states for an event.
  @protected
  @visibleForOverriding
  Stream<State> mapEventToStates(Event event);
}
