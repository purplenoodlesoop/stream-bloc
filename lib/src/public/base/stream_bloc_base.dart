import 'package:stream_bloc/src/private/base/stream_bloc_internal_base.dart';
import 'package:stream_bloc/src/private/mixins/stream_bloc_hooks_mixin.dart';
import 'package:stream_bloc/src/private/mixins/stream_bloc_transformers_mixin.dart';

abstract class StreamBlocBase<State extends Object?,
        Event extends Object?> = StreamBlocInternalBase<State, Event>
    with
        StreamBlocHooksMixin<State, Event>,
        StreamBlocTransformersMixin<State, Event>;
