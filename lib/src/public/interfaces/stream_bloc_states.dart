abstract class StreamBlocStates<Event extends Object?, State extends Object?> {
  /// This transformer is a shorthand for Stream.where followed by Stream.cast.
  ///
  /// [State]'s that do not match [T] are filtered out,
  ///  the resulting Stream will be of Type [T].
  Stream<T> whereState<T extends Object?>();

  /// Filter with whereState<T>() and after that
  /// skips [State]'s if they are equal to the previous data event.
  ///
  /// [State]'s that do not match [T] are filtered out,
  ///  the resulting Stream will be of Type [T].
  Stream<T> whereUnique<T extends Object?>();

  /// This transformer leaves only the necessary states with downcast to [T]
  ///
  /// [State]'s that do not match [T] are filtered out,
  ///  the resulting Stream will be of Type [T].
  Stream<T> whereStates<T extends Object?>(bool Function(State state) filter);

  /// Filter with whereStates<T>() and after that
  /// skips [State]'s if they are equal to the previous data event.
  /// Downcast states to [T]
  ///
  /// [State]'s that do not match [T] are filtered out,
  ///  the resulting Stream will be of Type [T].
  Stream<T> whereUniques<T extends Object?>(bool Function(State state) filter);
}
