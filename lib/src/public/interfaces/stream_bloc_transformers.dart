import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

/// Signature for a mapper function which takes an [Event] as input
/// and outputs a [Stream] of [Transition] objects.
typedef TransitionFunction<Event, State> = Stream<Transition<Event, State>>
    Function(Event event);

/// An interface that allows transforming its events and following transitions
abstract class StreamBlocTransformers<Event extends Object?,
    State extends Object?> {
  /// Transforms the `Stream<Event>` into a new `Stream<Event>`.
  /// By default [transformSourceEvents] returns the incoming `Stream<Event>`.
  /// You can override [transformSourceEvents] in order to manipulate the
  /// frequency and specificity at which incoming `events` are delivered.
  ///
  /// The incoming events can be transformed in the [transformEvents], but
  /// [transformSourceEvents] is a more appropriate place to do so.
  ///
  /// For example, if you want to throttle incoming events:
  ///
  /// ```dart
  /// @override
  /// Stream<Events> transformSourceEvents(
  ///   Stream<Event> events,
  /// ) {
  ///   return events.throttle(Duration(seconds: 1));
  /// }
  /// ```
  @protected
  @visibleForOverriding
  Stream<Event> transformSourceEvents(
    Stream<Event> events,
  );

  /// Transforms the [events] stream along with a [transitionFn] function into
  /// a `Stream<Transition>`.
  /// Events that should be processed by [mapEventToStates] need to be passed to
  /// [transitionFn].
  /// By default `asyncExpand` is used to ensure all [events] are processed in
  /// the order in which they are received.
  /// You can override [transformEvents] for advanced usage in order to
  /// manipulate the frequency and specificity with which [mapEventToStates] is
  /// called as well as which [events] are processed.
  ///
  /// For example, if you only want [mapEventToStates] to be called on the most
  /// recent [Event] you can use `switchMap` instead of `asyncExpand`.
  ///
  /// ```dart
  /// @override
  /// Stream<Transition<Event, State>> transformEvents(events, transitionFn) {
  ///   return events.switchMap(transitionFn);
  /// }
  /// ```
  @protected
  @visibleForOverriding
  Stream<Transition<Event, State>> transformEvents(
    Stream<Event> events,
    TransitionFunction<Event, State> transitionFn,
  );

  /// Transforms the `Stream<Transition>` into a new `Stream<Transition>`.
  /// By default [transformTransitions] returns
  /// the incoming `Stream<Transition>`.
  /// You can override [transformTransitions] for advanced usage in order to
  /// manipulate the frequency and specificity at which `transitions`
  /// (state changes) occur.
  ///
  /// For example, if you want to debounce outgoing state changes:
  ///
  /// ```dart
  /// @override
  /// Stream<Transition<Event, State>> transformTransitions(
  ///   Stream<Transition<Event, State>> transitions,
  /// ) {
  ///   return transitions.debounceTime(Duration(seconds: 1));
  /// }
  /// ```
  @protected
  @visibleForOverriding
  Stream<Transition<Event, State>> transformTransitions(
    Stream<Transition<Event, State>> transitions,
  );
}
