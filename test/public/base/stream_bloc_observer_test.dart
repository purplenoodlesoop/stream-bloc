// ignore_for_file: deprecated_member_use_from_same_package

import 'dart:async';

import 'package:meta/meta.dart';
import 'package:stream_bloc/stream_bloc.dart';
import 'package:test/test.dart';

@visibleForTesting
class TestStreamBlocObserver extends StreamBlocObserver {}

void main() {
  group('StreamBlocObserver', () {
    test(
      'should return same observer instance when override [zoneValues]',
      () async {
        // arrange
        final observer = TestStreamBlocObserver();

        // act
        final result = StreamBlocObserver.inject(
          observer,
          () => runZoned(
            () => StreamBlocObserver.current,
            zoneValues: {const Object(): TestStreamBlocObserver()},
          ),
        );

        // assert
        expect(result, same(observer));
      },
    );
  });
}
