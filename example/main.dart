import 'package:stream_bloc/stream_bloc.dart';

abstract class CounterEvent {}

class Increment implements CounterEvent {}

class Decrement implements CounterEvent {}

class CounterBloc extends StreamBloc<CounterEvent, int> {
  CounterBloc() : super(0);

  @override
  Stream<int> mapEventToStates(CounterEvent event) async* {
    if (event is Increment) {
      yield state + 1;
    } else if (event is Decrement) {
      yield state - 1;
    }
  }
}

Future<void> main(List<String> arguments) async {
  final bloc = CounterBloc();

  final printSubscription = bloc.stream.listen(print);

  bloc
    ..add(Increment())
    ..add(Increment())
    ..add(Increment())
    ..add(Decrement());
  await Future<void>.delayed(Duration.zero);

  await printSubscription.cancel();
}
