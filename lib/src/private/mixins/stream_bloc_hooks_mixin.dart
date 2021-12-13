// ignore_for_file: invalid_use_of_protected_member

import 'package:bloc/bloc.dart';
import 'package:stream_bloc/src/private/base/stream_bloc_internal_base.dart';
import 'package:stream_bloc/src/public/interfaces/stream_bloc_hooks.dart';
import 'package:stream_bloc/src/public/interfaces/stream_bloc_observer.dart';

mixin StreamBlocHooksMixin<State extends Object?, Event extends Object?>
    on StreamBlocInternalBase<State, Event>
    implements StreamBlocHooks<State, Event> {
  StreamBlocObserver? get _observer => StreamBlocObserver.current;

  @override
  void onEvent(Event event) {
    _observer?.onEvent(this, event);
  }

  @override
  void onChange(Change<State> change) {
    _observer?.onChange(this, change);
  }

  @override
  void onTransition(Transition<Event, State> transition) {
    _observer?.onTransition(this, transition);
  }

  @override
  void onError(Object error, StackTrace stackTrace) {
    _observer?.onError(this, error, stackTrace);
  }
}
