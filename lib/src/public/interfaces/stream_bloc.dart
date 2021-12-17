import 'package:bloc/bloc.dart';
import 'package:stream_bloc/src/public/interfaces/stream_bloc_hooks.dart';
import 'package:stream_bloc/src/public/interfaces/stream_bloc_mapper.dart';
import 'package:stream_bloc/src/public/interfaces/stream_bloc_transformers.dart';

abstract class IStreamBloc<Event extends Object?, State extends Object?>
    implements
        StateStreamableSource<State>,
        BlocEventSink<Event>,
        StreamBlocMapper<Event, State>,
        StreamBlocTransformers<Event, State>,
        StreamBlocHooks<Event, State> {}
