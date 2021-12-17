# stream_bloc

Modern implementation of the Original BLoC

## About

This package contains a modern implementation (`bloc` package version 8.0.0+) of the Original, Stream/generator-based BLoC with several improvements and convenience extras.

## Motivation

After the 7.2.0 version update, bloc has changed. Generators and the signature method `mapEventToState` was replaced to method-based pattern-matching using the `on` method and its argument handler. This approach is defiantly usable, but it lack a few thing.

1) Streams are powerful. They can be transformed natively using vast choice of transformers.
2) Generators are powerful. They allow to asynchronously return multiple values, including other streams.
3) New `on` approach makes `freezed` basically useless. It is possible to register just a single handler, but it negates the whole point of the `on` handlers.

This package brings back Original bloc with all the benefits, whilst maintaining 100% compatibility with `bloc` and `flutter_bloc` packages. The `StreamBloc`s can be used with all `flutter_bloc` widgets; they implement the same interfaces.

## Overview

## Improvements

## Extras

## Usage

