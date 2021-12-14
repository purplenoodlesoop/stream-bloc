import 'package:stream_bloc/stream_bloc.dart';

abstract class CounterEvent {}

class Increment implements CounterEvent {}

class Decrement implements CounterEvent {}

abstract class CounterBloc extends StreamBlocBase<int, CounterEvent> {
  CounterBloc(int initialState) : super(initialState);
}

class CounterBlocImpl extends CounterBloc {
  CounterBlocImpl() : super(0);

  @override
  Stream<int> mapEventToStates(CounterEvent event) async* {
    if (event is Increment) {
      yield state + 1;
    } else if (event is Decrement) {
      yield state - 1;
    }
  }
}

Future<void> nextEventLoop() => Future.delayed(Duration.zero);

Future<void> main(List<String> arguments) async {
  final CounterBloc bloc = CounterBlocImpl();

  final printSubscription = bloc.stream.listen(print);

  bloc
    ..add(Increment())
    ..add(Increment())
    ..add(Increment())
    ..add(Decrement());
  await nextEventLoop();

  await printSubscription.cancel();
}
