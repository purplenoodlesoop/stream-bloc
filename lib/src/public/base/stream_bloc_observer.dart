import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

/// Allows observing certain lifecycle stages of corresponding interfaces and
/// provides a mechanism of injecting itself through [Zone]s.
///
/// Combines in itself a [BlocObserver] with interface arguments and a
/// [BlocOverrides] that allows overriding only an observer.
abstract class StreamBlocObserver {
  const StreamBlocObserver();

  static const Object _tag = Object();

  /// Runs `body` in a fresh [Zone] using the provided `observer`.
  ///
  /// Similar to [BlocOverrides.runZoned].
  static R inject<R>(
    StreamBlocObserver observer,
    R Function() body,
  ) =>
      runZoned(body, zoneValues: {_tag: observer});

  /// Returns the current [StreamBlocObserver] instance.
  static StreamBlocObserver? get current =>
      Zone.current[_tag] as StreamBlocObserver?;

  /// Called whenever a [Bloc] is instantiated.
  /// In many cases, a cubit may be lazily instantiated and
  /// [onCreate] can be used to observe exactly when the cubit
  /// instance is created.
  @protected
  @mustCallSuper
  void onCreate(Closable closable) {}

  /// Called whenever an [event] is `added` to any [eventSink] with the given
  /// [eventSink] and [event].
  @protected
  @mustCallSuper
  void onEvent(BlocEventSink eventSink, Object? event) {}

  /// Called whenever a [Change] occurs in any [stateStreamable]
  /// A [change] occurs when a new state is emitted.
  /// [onChange] is called before a bloc's state has been updated.
  @protected
  @mustCallSuper
  void onChange(StateStreamable stateStreamable, Change change) {}

  /// Called whenever a transition occurs in any [bloc] with the given [bloc]
  /// and [transition].
  /// A [transition] occurs when a new `event` is added
  /// and a new state is `emitted` from a corresponding [EventHandler].
  /// [onTransition] is called before a [bloc]'s state has been updated.
  @protected
  @mustCallSuper
  void onTransition(BlocEventSink bloc, Transition transition) {}

  /// Called whenever an [error] is thrown in any [Bloc] or [Cubit].
  /// The [stackTrace] argument may be [StackTrace.empty] if an error
  /// was received without a stack trace.
  @protected
  @mustCallSuper
  void onError(ErrorSink errorSink, Object error, StackTrace stackTrace) {}

  /// Called whenever a [Bloc] is closed.
  /// [onClose] is called just before the [Bloc] is closed
  /// and indicates that the particular instance will no longer
  /// emit new states.
  @protected
  @mustCallSuper
  void onClose(Closable closable) {}
}
