## [0.6.0] – 2025-05-23

- Bumped `bloc` and `sdk` versions.

## [0.5.3] – 2022-11-12

### Fixed
- `StreamBloc`'s stream of events is made broadcast again, partially reverting [(#20)](https://github.com/purplenoodlesoop/stream-bloc/pull/20)


## [0.5.2] – 2022-09-19

### Changed
- Bumped `bloc` and `meta` dependencies.
- `BlocLifecycleMixin`s internal subscription list now is created lazily.

### Deprecated
- Deprecated `StreamBlocObserver.inject` and `StreamBlocObserverLocation.zone`, as [`Zone`d overrides introduce unnecessary complexity and can lead to bugs](https://github.com/felangel/bloc/issues/3470)

### Removed
- Removed previously deprecated `*toStreamable` methods of `BlocLifecycleMixin` as [Streamable-to-Streamable communications are discouraged](https://bloclibrary.dev/#/architecture?id=bloc-to-bloc-communication).

## [0.5.1] – 2022-06-13

### Changed
- Package and example refactoring thanks to [PlugFox (#20)](https://github.com/purplenoodlesoop/stream-bloc/pull/20)

## [0.5.0] – 2022-06-13
### Added
- `StreamBloc` now implements `Emittable` and has an `emit` method thanks to [Phat0M (#12)](https://github.com/purplenoodlesoop/stream-bloc/pull/12)

### Changed
- Refactored package structure for easier navigation and adherence to idiomatic project organization.
- Refactored `StreamBlocBase` – improved code style and enforced DRY principle.

### Deprecated
- Deprecated `listenToStreamable` and `reactToStreamable` methods of `BlocLifecycleMixin`, as [Streamable-to-Streamable communications are discouraged](https://bloclibrary.dev/#/architecture?id=bloc-to-bloc-communication).

### Removed
- Removed exports of `BlocObserver`, `BlocOverrides`, `Cubit`, `Emitter`, `EventHandler` from `bloc` package.

### Fixed
- `StreamBlocObserver`'s `Zone` key is made not `const` to avoid collisions thanks to [nxtSwitch (#11)](https://github.com/purplenoodlesoop/stream-bloc/pull/11)

## 0.4.0 - [13.04.2022]

### Added

- Add `purple_lints` as a package linter.
- Add `StreamBlocObserverConfig`, `StreamBlocObserverLocation` and static `StreamBlocObserver.config` variable, thus adding the static variable option for global injection of the `StreamBlocObserver`.
- Add Setter for the `StreamBlocObserver.current` variable.
- Add `const` constructor to the `StreamBlocObserver`.

### Changed

- Bump `bloc` dependency.

### Fixed

- Fix annotations for implemented and inherited methods.
- Fix documentation member references.
- Import `StreamBlocMapper`.

## 0.3.1 - [13.02.2022]

- Fixed `StreamBlocObserver`'s `StreamBlocObserver.current` getter.
- Dropped minimum package version constraint to `2.12.0`.

## 0.3.0 - [06.02.2022]

- Added `transformSourceEvents`.

## 0.2.1 - [04.02.2022]

- Fixed imports.

## 0.2.0 - [04.02.2022]

- Events stream is made broadcast.
- Package exports include the `bloc` package.
- Fixed meta dependency, bumping it to the latest version.
- Added missing `on...` arguments to `BlocLifecycleMixin`'s methods.
- `StreamBlocObserver`'s methods expect interfaces.
- Added missing documentation. The package is now 100% documented.

## 0.1.0 - [06.01.2022]

- Initial version.
