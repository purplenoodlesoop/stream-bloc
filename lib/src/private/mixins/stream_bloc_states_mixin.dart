import 'package:stream_bloc/src/private/base/stream_bloc_base.dart';
import 'package:stream_bloc/src/public/interfaces/stream_bloc_states.dart';

mixin StreamBlocStatesMixin<Event extends Object?, State extends Object?>
    on StreamBlocBase<Event, State> implements StreamBlocStates<Event, State> {
  /// This transformer is a shorthand for Stream.where followed by Stream.cast.
  ///
  /// [State]'s that do not match [T] are filtered out,
  ///  the resulting Stream will be of Type [T].
  @override
  Stream<T> whereState<T extends Object?>() =>
      stream.where((state) => state is T).cast<T>();

  /// Filter with whereState<T>() and after that
  /// skips [State]'s if they are equal to the previous data event.
  ///
  /// [State]'s that do not match [T] are filtered out,
  ///  the resulting Stream will be of Type [T].
  @override
  Stream<T> whereUnique<T extends Object?>() => whereState<T>().distinct();

  /// This transformer leaves only the necessary states with downcast to [T]
  ///
  /// [State]'s that do not match [T] are filtered out,
  ///  the resulting Stream will be of Type [T].
  @override
  Stream<T> whereStates<T extends Object?>(bool Function(State state) filter) =>
      stream.where(filter).where((state) => state is T).cast<T>();

  /// Filter with whereStates<T>() and after that
  /// skips [State]'s if they are equal to the previous data event.
  /// Downcast states to [T]
  ///
  /// [State]'s that do not match [T] are filtered out,
  ///  the resulting Stream will be of Type [T].
  @override
  Stream<T> whereUniques<T extends Object?>(
          bool Function(State state) filter) =>
      whereStates<T>(filter).distinct();
}
