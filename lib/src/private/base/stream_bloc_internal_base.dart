// ignore_for_file: invalid_use_of_protected_member, invalid_use_of_visible_for_overriding_member

import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:stream_bloc/src/public/interfaces/stream_bloc.dart';
import 'package:stream_bloc/stream_bloc.dart';

abstract class StreamBlocInternalBase<State extends Object?,
    Event extends Object?> implements StreamBloc<State, Event> {
  late final StreamController<Event> _eventStreamController =
      StreamController();
  late final StreamController<State> _stateStreamController =
      StreamController.broadcast();

  StreamSubscription<Transition<Event, State>>? _transitionSubscription;

  State _state;

  StreamBlocInternalBase(State initialState) : _state = initialState {
    StreamBlocObserver.current?.onCreate(this);
    _bindEventsToStates();
  }

  Stream<Transition<Event, State>> get _transitions => transformEvents(
        _eventStreamController.stream,
        (event) => mapEventToStates(event).map(
          (nextState) => Transition(
            currentState: state,
            event: event,
            nextState: nextState,
          ),
        ),
      );

  void _processTransition(Transition<Event, State> transition) {
    try {
      onTransition(transition);
      if (!_stateStreamController.isClosed) {
        final newState = transition.nextState;
        onChange(Change(currentState: state, nextState: newState));
        _stateStreamController.add(_state = newState);
      }
    } on Object catch (error, stackTrace) {
      onError(error, stackTrace);
    }
  }

  void _bindEventsToStates() {
    _transitionSubscription = transformTransitions(_transitions).listen(
      _processTransition,
      onError: onError,
      cancelOnError: false,
    );
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
  void addError(Object error, [StackTrace? stackTrace]) {
    onError(error, stackTrace ?? StackTrace.current);
  }

  @override
  FutureOr<void> close() async {
    await _eventStreamController.close();
    await _transitionSubscription?.cancel();
    StreamBlocObserver.current?.onClose(this);
    await _stateStreamController.close();
  }

  @override
  bool get isClosed => _stateStreamController.isClosed;

  @override
  State get state => _state;

  @override
  Stream<State> get stream => _stateStreamController.stream;
}
