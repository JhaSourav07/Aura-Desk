# Aura Desk

[![Flutter](https://img.shields.io/badge/Flutter-02569B?style=flat&logo=flutter&logoColor=white)](https://flutter.dev/)
[![Dart](https://img.shields.io/badge/Dart-0175C2?style=flat&logo=dart&logoColor=white)](https://dart.dev/)

Aura Desk is a dark-mode Flutter UI prototype for controlling a smart desk lamp and related devices (lamp, fan, printer, alarm). It showcases an interactive interface and visual flows for a smart desk control app.

Important: This is a frontend UI prototype only. There is no backend, Bluetooth, or hardware-control logic in this repository — interactions are mock/visual only.

## Key Features

- Dashboard — quick overview and shortcuts
- Lamp — power, brightness, color presets
- Fan — power, speed settings
- Printer — status and quick actions
- Alarms — create, edit, and toggle alarms

## Screenshots

(Replace these with actual screenshots from the app)
- Dark dashboard
- Lamp control view
- Fan control view
- Printer status view
- Alarms list and editor

## Getting Started

Prerequisites:
- Flutter SDK (stable channel recommended)
- An Android/iOS device or emulator

Clone and run:

```bash
git clone https://github.com/JhaSourav07/Aura-Desk.git
cd Aura-Desk
flutter pub get
flutter run
```

Notes:
- The app is a frontend prototype. Controls are interactive in the UI but do not communicate with real devices.
- To integrate with hardware (Bluetooth, MQTT, HTTP APIs, etc.), add the appropriate services and platform plugins and replace the UI mock handlers with real implementations.

## Project Structure (high level)

- lib/ — Flutter app source
  - screens/ — UI screens (Dashboard, Lamp, Fan, Printer, Alarms)
  - widgets/ — reusable UI components
  - models/ — data models (used for UI state only)
- assets/ — images, icons, fonts

## Contributing

Contributions are welcome (UI improvements, new mock flows, accessibility, theming). Please open an issue or submit a pull request. When contributing, please keep in mind this project intentionally has no hardware/back-end integrations.

## License

Specify your license here (e.g., MIT). If you don't have one yet, consider adding a LICENSE file.

## Contact

Created by JhaSourav07 — https://github.com/JhaSourav07