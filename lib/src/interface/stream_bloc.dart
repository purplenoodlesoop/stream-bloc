import 'package:stream_bloc/src/interface/stream_bloc_hooks.dart';
import 'package:stream_bloc/src/interface/stream_bloc_mapper.dart';
import 'package:stream_bloc/src/interface/stream_bloc_transformers.dart';

/// An interface that combines [StreamBlocMapper], [StreamBlocTransformers] and
/// [StreamBlocHooks] and represents all required methods for a `StreamBloc`
abstract class IStreamBloc<Event extends Object?, State extends Object?>
    implements
        StreamBlocMapper<Event, State>,
        StreamBlocTransformers<Event, State>,
        StreamBlocHooks<Event, State> {}
