import 'package:meta/meta.dart';

abstract class StreamBlocMapper<State extends Object?, Event extends Object?> {
  /// Must be implemented when a class extends [StreamBloc].
  /// [mapEventToStates] is called whenever an [event] is [add]ed
  /// and is responsible for converting that [event] into a new [state].
  /// [mapEventToStates] can `yield` zero, one, or multiple states for an event.
  @protected
  @visibleForOverriding
  Stream<State> mapEventToStates(Event event);
}
