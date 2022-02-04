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

This package brings back Original bloc with all the benefits, whilst maintaining 100% compatibility with `bloc` and `flutter_bloc` packages. The `StreamBloc`s can be used with all `flutter_bloc` widgets; they implement the same interfaces.

## Overview

If you are familiar with the bloc before the 8.0.0/7.2.0 you are familiar with `StreamBloc` – the central class of this package. Documentation for previous bloc's versions can be used for this packages besides a few modifications that are listed in the next section.

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

There are four main differences from the Original bloc.

1) `mapEventToState` is renamed to `mapEventToStates`. The method returns an asynchronous sequence of states – not a single state.

2) `StreamBloc`'s type parameters/generics are constrained to subclasses of an `Object?`.

3) It is not possible to emit a new state without it being a response to a certain event. `StreamBloc` does not implement `Emittable` and does not have an `emit` method. The original bloc has its method because both `Cubit` and `Bloc` are descendants of the same base class, but `emit` should not be used within a `Bloc`. It is marked as visible for testing, but it is always a good idea to test a whole instead of its parts.

4) Bloc can emit identical states consequentially. The output stream of the `StreamBloc` is not distinct because of two main reasons
    - `flutter_bloc`'s `BlocListener`/`BlocConsumer` may be interested in any new emitted state, even if the state had not changed
    - `stream.map(...)`/`stream.where(...)` (essentially `BlocBuilder` and/or `BlocSelector`) applied to `stream.distinct()` removes the guarantee of uniques event in the stream, making the `distinct` redundant; it should be applied last, not first.

## Extras

The package also offers a single convenience mixin `BlocLifecycleMixin` which makes Bloc-to-Bloc communications easier. It offers four methods: `listenToStream`, `listenToStreamable`, `reactToStream` and `reactToStreamable`. Below is an example of its usage.

```dart

enum EventA { eventA }

class BlocA extends StreamBloc<EventA, int> {
  BlocA() : super(0);

  @override
  Stream<int> mapEventToStates(EventA event) => Stream.value(1);
}

enum EventB { eventB }

class BlocB extends StreamBloc<EventB, int> with BlocLifecycleMixin<EventB> {
  BlocB(BlocA blocA) : super(0) {
    /// Will print every new state of this Bloc to the console.
    listenToStream(stream, print);

    /// Will add [EventB.eventB] to this bloc every time BlocA emits any state.
    reactToStreamable<int>(blocA, (blocAState) => EventB.eventB);
  }

  @override
  Stream<int> mapEventToStates(EventB event) => Stream.value(1);
}

```

All methods return an instance of `StreamSubscription` which can be canceled by hand if desired, but it is optional – it will be canceled any way on the closing of a Bloc that mixes in `BlocLifecycleMixin`
