# stream_bloc

[![Pub](https://img.shields.io/pub/v/stream_bloc.svg)](https://pub.dev/packages/stream_bloc)
[![GitHub Stars](https://img.shields.io/github/stars/purplenoodlesoop/stream-bloc.svg)](https://github.com/purplenoodlesoop/stream-bloc)
[![License: MIT](https://img.shields.io/badge/License-MIT-brightgreen.svg)](https://en.wikipedia.org/wiki/MIT_License)
[![Linter](https://img.shields.io/badge/style-custom-brightgreen)](https://github.com/purplenoodlesoop/stream-bloc/blob/master/analysis_options.yaml)
[![Code size](https://img.shields.io/github/languages/code-size/purplenoodlesoop/stream-bloc)](https://github.com/purplenoodlesoop/stream-bloc)

---

Modern implementation of the Original BLoC

## About

This package contains a modern (`bloc` package version 8.0.0+) implementation of the Original, Stream/generator-based BLoC with several modifications and convenience extras.

## Motivation

After the 7.2.0 version update, the bloc has changed. Generators and the signature method `mapEventToState` were replaced with method-based pattern-matching using the `on` method and its argument handler. This approach is defiantly usable and solves a particular bug of the Dart language itself, but it lacks a few things.

1) Power of streams. They can be transformed natively using a vast choice of transformers, but with the new bloc, streams are hidden under the hood and are not "first-class citizens".
2) Power of generators. They allow to asynchronously return multiple values, including other streams. The new version emulates their behavior using higher-order functions.
3) New `on` approach makes `freezed` basically useless. It is possible to register just a single handler, but it negates the whole point of the `on` handlers.

This package brings back the Original bloc with all the benefits, whilst maintaining 100% compatibility with `bloc` and `flutter_bloc` packages. The `StreamBloc`s can be used with all `flutter_bloc` widgets; they implement the same interfaces.

## Overview

If you are familiar with the bloc before the 8.0.0/7.2.0 you are familiar with `StreamBloc` – the central class of this package. Documentation for previous bloc's versions can be used for this package besides a few modifications that are listed in the next section.

`StreamBloc` uses a central event-processing method called `mapEventToStates` to convert a single Event to a Stream of States that are emitted asynchronously. Official `Bloc` can be directly translated to `StreamBloc` as described below.

**It is highly advised to use freezed package. The following example is a demonstration and should not be considered a "Best practice" for StreamBloc**

```dart



abstract class CounterEvent {} // Shared counter event type

class Increment implements CounterEvent {} // Increment counter event

class Decrement implements CounterEvent {} // Decrement counter event

class OnCounterBloc extends Bloc<CounterEvent, int> { // Official Bloc – `on`s
  OnCounterBloc() : super(0) {
    on<Increment>((event, emit) => emit(state + 1));
    on<Decrement>((event, emit) => emit(state - 1));
  }
}

class StreamCounterBloc extends StreamBloc<CounterEvent, int> { // StreamBloc – `mapEventToStates`
  StreamCounterBloc() : super(0);

  @override
  Stream<int> mapEventToStates(CounterEvent event) async* {
    if (event is Increment) {
      yield state + 1;
    } else if (event is Decrement) {
      yield state - 1;
    }
  }
}

```

## Modifications

There are five main differences from the Original bloc.

1) `mapEventToState` is renamed to `mapEventToStates`. The method returns an asynchronous sequence of states – not a single state.

2) `StreamBloc`'s type parameters/generics are constrained to subclasses of an `Object?`.

3) Bloc can emit identical states consequentially. The output stream of the `StreamBloc` is not distinct because of two main reasons
    - `flutter_bloc`'s `BlocListener`/`BlocConsumer` may be interested in any new emitted state, even if the state had not changed
    - `stream.map(...)`/`stream.where(...)` (essentially `BlocBuilder` and/or `BlocSelector`) applied to `stream.distinct()` removes the guarantee of uniques event in the stream, making the `distinct` redundant; it should be applied last, not first.

4) Bloc Observer can be injected both through zone injection and static variable with the specified priority.

5) Bloc Transformers is extended with an additional method that transforms source events and is applied before the events-transitions transformer.

## Extras

The package also offers a single convenience mixin `BlocLifecycleMixin` which makes Bloc-to-Bloc communications easier. It offers two methods: `listenToStream` and `listenToStreamable`. Below is an example of its usage.

```dart

class IncrementEvent {
  final int amount;

  const IncrementEvent(this.amount);
}

class IncrementBloc extends StreamBloc<IncrementEvent, int>
    with BlocLifecycleMixin {
  IncrementBloc() : super(0) {
    reactToStream<int>(
      Stream.periodic(const Duration(seconds: 1), (i) => i),
      (passed) => IncrementEvent(passed),
    );

    listenToStream<int>(
      stream,
      print,
    );
  }

  @override
  Stream<int> mapEventToStates(IncrementEvent event) => Stream.value(
        state + event.amount,
      );
}

```

All methods return an instance of `StreamSubscription` which can be canceled by hand if desired, but it is optional – it will be canceled any way on the closing of a Bloc that mixes in `BlocLifecycleMixin`
