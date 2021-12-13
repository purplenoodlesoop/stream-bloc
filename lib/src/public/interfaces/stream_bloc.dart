import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:stream_bloc/src/public/interfaces/stream_bloc_hooks.dart';
import 'package:stream_bloc/src/public/interfaces/stream_bloc_transformers.dart';

abstract class StreamBloc<State extends Object?, Event extends Object?>
    implements
        StateStreamableSource<State>,
        BlocEventSink<Event>,
        StreamBlocTransformers<State, Event>,
        StreamBlocHooks<State, Event> {
  /// Whether the bloc is closed.
  ///
  /// A bloc is considered closed once [close] is called.
  /// Subsequent state changes cannot occur within a closed bloc.
  bool get isClosed;

  /// Must be implemented when a class extends [StreamBloc].
  /// [mapEventToStates] is called whenever an [event] is [add]ed
  /// and is responsible for converting that [event] into a new [state].
  /// [mapEventToStates] can `yield` zero, one, or multiple states for an event.
  @protected
  @visibleForOverriding
  Stream<State> mapEventToStates(Event event);
}
