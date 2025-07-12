# Closet Tracker

A simple Flutter app to keep track of your clothes and shoes. Add items with a photo and name, mark them when worn, and receive reminders when something hasn’t been worn for more than 30 days.

## Features

- Add new item with photo from gallery and name
- Item list shows photo, name, and last-worn date
- Tap an item to mark it as worn today
- Items not worn for 30+ days are highlighted with a warning icon/color
- All data stored locally with Hive (no internet needed)

## Getting Started

1. **Install Flutter SDK** (https://flutter.dev/docs/get-started/install)
2. Clone this repository and open the project folder.
3. Get dependencies:

```bash
flutter pub get
```

4. Run the app on an emulator or device:

```bash
flutter run
```

### Code Generation (optional)
A manual Hive adapter is included, so running build_runner is not required. If you prefer generated code, delete `lib/models/clothing_item.g.dart` and run:

```bash
flutter pub run build_runner build --delete-conflicting-outputs
```

## Dependencies
- flutter
- hive & hive_flutter
- path_provider
- image_picker
- intl
- path

---
Made with ❤️ in Flutter.