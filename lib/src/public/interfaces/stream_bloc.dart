import 'package:bloc/bloc.dart';
import 'package:stream_bloc/src/public/interfaces/stream_bloc_hooks.dart';
import 'package:stream_bloc/src/public/interfaces/stream_bloc_mapper.dart';
import 'package:stream_bloc/src/public/interfaces/stream_bloc_transformers.dart';

abstract class StreamBloc<State extends Object?, Event extends Object?>
    implements
        StateStreamableSource<State>,
        BlocEventSink<Event>,
        StreamBlocMapper<State, Event>,
        StreamBlocTransformers<State, Event>,
        StreamBlocHooks<State, Event> {
  /// Whether the bloc is closed.
  ///
  /// A bloc is considered closed once [close] is called.
  /// Subsequent state changes cannot occur within a closed bloc.
  bool get isClosed;
}
