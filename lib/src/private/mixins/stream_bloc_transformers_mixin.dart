import 'package:bloc/bloc.dart';
import 'package:stream_bloc/src/private/base/stream_bloc_base.dart';
import 'package:stream_bloc/src/public/interfaces/stream_bloc_transformers.dart';

mixin StreamBlocTransformersMixin<Event extends Object?, State extends Object?>
    on StreamBlocBase<Event, State>
    implements StreamBlocTransformers<Event, State> {
  @override
  Stream<Transition<Event, State>> transformTransitions(
    Stream<Transition<Event, State>> transitions,
  ) =>
      transitions;

  @override
  Stream<Transition<Event, State>> transformEvents(
    Stream<Event> events,
    TransitionFunction<Event, State> transitionFn,
  ) =>
      events.asyncExpand(transitionFn);
}
