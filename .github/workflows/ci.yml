name: CI
on:
  pull_request:
    branches:
      - master

jobs:
  flutter_test:
    name: Run flutter test and analyze
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v2
      - uses: actions/setup-java@v1
        with:
          java-version: "12.x"
      - uses: subosito/flutter-action@v1
        with:
          channel: "stable"
      - run: flutter pub get
      - run: flutter analyze
      - run: flutter test

  build_ios:
    name: Build Flutter (iOS)
    needs: [flutter_test]
    runs-on: macos-latest
    steps:
      - uses: actions/checkout@v2
      - uses: actions/setup-java@v1
        with:
          java-version: "12.x"
      - uses: subosito/flutter-action@v1
        with:
          channel: "stable"
      - run: flutter pub get
      - run: flutter clean
      - run: flutter build ios --release --no-codesign

  build_appbundle:
    name: Build Flutter (Android)
    needs: [flutter_test]
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v2
      - uses: actions/setup-java@v1
        with:
          java-version: "12.x"
      - uses: subosito/flutter-action@v1
        with:
          channel: "stable"
      - run: flutter pub get
      - run: flutter clean
      - run: flutter build appbundle