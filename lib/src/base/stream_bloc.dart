import 'package:stream_bloc/src/base/stream_bloc_base.dart';
import 'package:stream_bloc/src/interface/stream_bloc.dart';
import 'package:stream_bloc/src/mixin/stream_bloc_hooks_mixin.dart';
import 'package:stream_bloc/src/mixin/stream_bloc_transformers_mixin.dart';

/// Transforms input `Events` using
// ignore: comment_references
/// [mapEventToStates] into [Stream] of [State]s
/// as an output.
///
/// Almost identical to pre-`7.2.0` Bloc from the `bloc` package.
abstract class StreamBloc<Event extends Object?,
        State extends Object?> = StreamBlocBase<Event, State>
    with
        StreamBlocHooksMixin<Event, State>,
        StreamBlocTransformersMixin<Event, State>
    implements IStreamBloc<Event, State>;
