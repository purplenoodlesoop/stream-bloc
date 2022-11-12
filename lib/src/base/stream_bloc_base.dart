// ignore_for_file: invalid_use_of_protected_member

import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:stream_bloc/src/base/stream_bloc_observer.dart';
import 'package:stream_bloc/src/interface/stream_bloc_hooks.dart';
import 'package:stream_bloc/src/interface/stream_bloc_mapper.dart';
import 'package:stream_bloc/src/interface/stream_bloc_transformers.dart';

abstract class StreamBlocBase<Event extends Object?, State extends Object?>
    implements
        BlocEventSink<Event>,
        StateStreamableSource<State>,
        StreamBlocMapper<Event, State>,
        StreamBlocTransformers<Event, State>,
        StreamBlocHooks<Event, State>,
        Emittable<State> {
  StreamBlocBase(State initialState) : _state = initialState {
    StreamBlocObserver.current?.onCreate(this);
    _bindEventsToStates();
  }

  State _state;

  late final StreamSubscription<Transition<Event, State>>
      _transitionSubscription;

  final StreamController<Event> _eventStreamController =
      StreamController.broadcast();
  late final StreamController<State> _stateStreamController =
      StreamController.broadcast();

  @override
  bool get isClosed => _stateStreamController.isClosed;

  @override
  State get state => _state;

  @override
  Stream<State> get stream => _stateStreamController.stream;

  Stream<Transition<Event, State>> _mapEventToTransitions(Event event) =>
      mapEventToStates(event).map(
        (nextState) => Transition(
          event: event,
          currentState: state,
          nextState: nextState,
        ),
      );

  void _emitUnchecked(State state) {
    onChange(Change(currentState: _state, nextState: state));
    if (state != _state) _state = state;
    _stateStreamController.add(_state);
  }

  void _processTransition(Transition<Event, State> transition) {
    try {
      if (!isClosed) {
        onTransition(transition);
        _emitUnchecked(transition.nextState);
      }
    } on Object catch (error, stackTrace) {
      onError(error, stackTrace);
    }
  }

  void _bindEventsToStates() {
    _transitionSubscription = transformTransitions(
      transformEvents(
        transformSourceEvents(_eventStreamController.stream),
        _mapEventToTransitions,
      ),
    ).listen(
      _processTransition,
      onError: onError,
      cancelOnError: false,
    );
  }

  @override
  @protected
  @visibleForTesting
  void emit(State state) {
    try {
      if (isClosed) {
        throw StateError('Cannot emit new states after calling close');
      }
      _emitUnchecked(state);
    } on Object catch (error, stackTrace) {
      onError(error, stackTrace);
      rethrow;
    }
  }

  @override
  void add(Event event) {
    try {
      onEvent(event);
      _eventStreamController.add(event);
    } on Object catch (error, stackTrace) {
      onError(error, stackTrace);
      rethrow;
    }
  }

  @override
  @protected
  void addError(Object error, [StackTrace? stackTrace]) {
    onError(error, stackTrace ?? StackTrace.current);
  }

  @override
  FutureOr<void> close() async {
    await _eventStreamController.close();
    await _transitionSubscription.cancel();
    StreamBlocObserver.current?.onClose(this);
    await _stateStreamController.close();
  }
}
