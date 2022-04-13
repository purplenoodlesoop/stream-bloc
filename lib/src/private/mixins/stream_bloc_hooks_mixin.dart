// ignore_for_file: invalid_use_of_protected_member

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:stream_bloc/src/private/base/stream_bloc_base.dart';
import 'package:stream_bloc/src/public/base/stream_bloc_observer.dart';
import 'package:stream_bloc/src/public/interfaces/stream_bloc_hooks.dart';

mixin StreamBlocHooksMixin<Event extends Object?, State extends Object?>
    on StreamBlocBase<Event, State> implements StreamBlocHooks<Event, State> {
  StreamBlocObserver? get _observer => StreamBlocObserver.current;

  @mustCallSuper
  @protected
  @override
  void onEvent(Event event) {
    _observer?.onEvent(this, event);
  }

  @mustCallSuper
  @protected
  @override
  void onChange(Change<State> change) {
    _observer?.onChange(this, change);
  }

  @mustCallSuper
  @protected
  @override
  void onTransition(Transition<Event, State> transition) {
    _observer?.onTransition(this, transition);
  }

  @mustCallSuper
  @protected
  @override
  void onError(Object error, StackTrace stackTrace) {
    _observer?.onError(this, error, stackTrace);
  }
}
