import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:stream_bloc/src/interface/stream_bloc.dart';

/// An interface that implement [BlocEventSink] and [StateStreamableSource],
/// adding a [mapEventToStates] method, a method that describes an asynchronous
/// "one-to-many" relationship between `events` and `states`.
abstract class StreamBlocMapper<Event extends Object?, State extends Object?>
    implements BlocEventSink<Event>, StateStreamableSource<State> {
  /// Must be implemented when a class extends [IStreamBloc].
  /// [mapEventToStates] is called whenever an [event] is [add]ed
  /// and is responsible for converting that [event] into a new [state].
  /// [mapEventToStates] can `yield` zero, one, or multiple states for an event.
  @protected
  @visibleForOverriding
  Stream<State> mapEventToStates(Event event);
}
