// ignore_for_file: avoid_print

import 'package:meta/meta.dart';
import 'package:stream_bloc/stream_bloc.dart';

@immutable
abstract class CounterEvent {
  T map<T>({
    required T Function(Increment event) increment,
    required T Function(Decrement event) decrement,
  });
}

class Increment extends CounterEvent {
  @override
  T map<T>({
    required T Function(Increment event) increment,
    required T Function(Decrement event) decrement,
  }) =>
      increment(this);
}

class Decrement extends CounterEvent {
  @override
  T map<T>({
    required T Function(Increment event) increment,
    required T Function(Decrement event) decrement,
  }) =>
      decrement(this);
}

class CounterBloc extends StreamBloc<CounterEvent, int> {
  CounterBloc() : super(0);

  @override
  Stream<int> mapEventToStates(CounterEvent event) => event.map(
        increment: _increment,
        decrement: _decrement,
      );

  Stream<int> _increment(Increment event) async* {
    yield state + 1;
  }

  Stream<int> _decrement(Decrement event) async* {
    yield state - 1;
  }
}

void main([List<String>? arguments]) {
  final bloc = CounterBloc();
  final printSubscription = bloc.stream.listen(print);
  bloc
    ..add(Increment())
    ..add(Increment())
    ..add(Increment())
    ..add(Decrement());
  Future(printSubscription.cancel).whenComplete(bloc.close);
}
