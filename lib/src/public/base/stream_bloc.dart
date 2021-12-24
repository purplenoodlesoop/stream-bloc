import 'package:stream_bloc/src/private/base/stream_bloc_base.dart';
import 'package:stream_bloc/src/private/mixins/stream_bloc_hooks_mixin.dart';
import 'package:stream_bloc/src/private/mixins/stream_bloc_transformers_mixin.dart';
import 'package:stream_bloc/src/public/interfaces/stream_bloc.dart';

abstract class StreamBloc<Event extends Object?,
        State extends Object?> = StreamBlocBase<Event, State>
    with
        StreamBlocHooksMixin<Event, State>,
        StreamBlocTransformersMixin<Event, State>
    implements IStreamBloc<Event, State>;
