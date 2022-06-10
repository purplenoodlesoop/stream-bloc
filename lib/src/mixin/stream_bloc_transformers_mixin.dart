import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:stream_bloc/src/base/stream_bloc_base.dart';
import 'package:stream_bloc/src/interface/stream_bloc_transformers.dart';

mixin StreamBlocTransformersMixin<Event extends Object?, State extends Object?>
    on StreamBlocBase<Event, State>
    implements StreamBlocTransformers<Event, State> {
  @protected
  @visibleForOverriding
  @override
  Stream<Event> transformSourceEvents(Stream<Event> events) => events;

  @protected
  @visibleForOverriding
  @override
  Stream<Transition<Event, State>> transformEvents(
    Stream<Event> events,
    TransitionFunction<Event, State> transitionFn,
  ) =>
      events.asyncExpand(transitionFn);

  @protected
  @visibleForOverriding
  @override
  Stream<Transition<Event, State>> transformTransitions(
    Stream<Transition<Event, State>> transitions,
  ) =>
      transitions;
}
