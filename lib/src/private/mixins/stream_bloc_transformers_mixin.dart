import 'package:bloc/bloc.dart';
import 'package:stream_bloc/src/public/interfaces/stream_bloc_transformers.dart';

mixin StreamBlocTransformersMixin<State extends Object?, Event extends Object?>
    on Object implements StreamBlocTransformers<State, Event> {
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
