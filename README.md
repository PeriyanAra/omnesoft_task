# omnesoft_task

Flutter app that displays a list of vendors with search, pagination, and vendor details. Data is fetched from a mock API and cached locally (SQLite via `sqflite`) for offline fallback.

## Setup instructions

### Prerequisites

- Flutter SDK installed (Dart SDK constraint is `^3.7.2` per `pubspec.yaml`).
- Xcode (for iOS) and/or Android Studio + Android SDK (for Android).

Quick checks:

```bash
fvm flutter --version
fvm flutter doctor
```

### Install dependencies

From the repo root:

```bash
fvm flutter pub get
```

### Generate code (AutoRoute)

This project uses `auto_route` with generated routes. Run:

```bash
fvm flutter pub run build_runner build --delete-conflicting-outputs
```

### Run the app

Android:

```bash
fvm flutter run -d android
```

iOS:

```bash
fvm flutter run -d ios
```

### Run tests

```bash
fvm flutter test
```

Optional coverage:

```bash
fvm flutter test --coverage
```

## Architecture decisions

This codebase follows a clean architecture's concepts and rules:

- **Presentation layer** (`lib/presentation/`)

  - Flutter widgets/screens and UI logic.
  - State management uses **BLoC/Cubit** (e.g. `HomeCubit`) to load vendors, handle search, and pagination.
  - Navigation uses **AutoRoute** (`lib/presentation/router/`).

- **Domain layer** (`lib/domain/`)

  - Plain Dart entities and repository contracts/usage.
  - `VendorEntity` is the domain model consumed by the UI.

- **Data layer** (`lib/data/`)

  - DTOs (`VendorDto`) and data sources.
  - **Remote**: `MockVendorApiService` generates fake vendor data.
  - **Local cache**: SQLite-backed cache used for offline fallback.

- **Infrastructure / Shared**
  - `lib/omnesoft_app_shared/` contains shared abstractions like `CacheDatabase` and DI helpers.
  - `lib/infrastructure/cache/` registers the Sqflite database and runs migrations (e.g. vendors table).

### Why these choices?

- **BLoC/Cubit**: predictable state transitions and easy widget testing of state-driven UI.
- **Repository pattern**: centralizes “remote first, local fallback” and keeps UI independent of storage/network details.
- **CacheDatabase abstraction**: keeps migrations and data access portable if the backing store changes later.
- **AutoRoute**: explicit typed routes and generated boilerplate for navigation.

## Assumptions made

- Vendor data is served by a **mock API** (randomized via `faker`) and can be refreshed repeatedly.
- The app should cache vendors locally and **fallback to cache** when the remote call fails.
- The vendors cache is treated as a full snapshot (implementation may clear and re-insert on refresh).
- Images are remote URLs; in tests we avoid loading real assets/network and only assert widget structure.
