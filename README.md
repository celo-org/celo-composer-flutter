# Celo Composer Flutter Template

A Flutter application template that integrates with Web3 functionality using ReOwn AppKit.

## Features

- Material Design 3 implementation
- Web3 wallet integration
- Provider state management
- Cross-platform support (iOS, Android, Web)

## Prerequisites

- Flutter SDK (^3.5.3)
- Dart SDK (^3.5.3)
- Git
- IDE (VS Code or Android Studio recommended)

## Installation

### 1\. Clone the Repository

```bash
git clone https://github.com/yourusername/flutter_template.git
cd flutter_template
```

### 2\. Set up Environment Variables

- Create a new file called `.env` in the root directory
- Copy the contents of `.env.example` into `.env` file
- Get your Reown WalletConnect ProjectID
    - Go to [WalletConnect Cloud](https://cloud.reown.com/)
    - Sign in or create an account
    - Create a new project or use an existing one
    - Copy the `Project ID`
- Replace `YOUR_PROJECT_ID` in ``.env`` with your actual Project ID



> **NOTE:** Make sure to add your iOS bundle ID or Android Package Name to the key whitelists so that they are allowed to use your Project ID key.

...

### 3\. Install Dependencies

```bash
# cd packages/flutter

flutter pub get
```

### 4\. Run the Application

```bash
flutter run
```

**Note:** Make sure you have an emulator running or a physical device connected before running the application.

## Project Structure

```bash
lib/
├── main.dart
├── providers/
│   └── app_provider.dart
├── screens/
│   └── home_screen.dart
└── widgets/
    ├── header.dart
    └── footer.dart
```

## Dependencies

- `provider: ^6.1.2` - State management solution
- `reown_appkit: ^1.2.0` - Web3 integration toolkit
- `cupertino_icons: ^1.0.8` - iOS-style icons

## Development

### Running in Debug Mode

```bash
flutter run
```

### Building for Production

```bash
# For Android
flutter build apk

# For iOS
flutter build ios

# For Web
flutter build web
```

### Running Tests

```bash
flutter test
```

## Platform-Specific Setup

### iOS

- Xcode 14 or later
- iOS 11.0 or later
- CocoaPods

### Android

- Android Studio
- Android SDK
- Android 5.0 (API 21) or later

## Contributing

1.  Fork the repository
2.  Create your feature branch (`git checkout -b feature/AmazingFeature`)
3.  Commit your changes (`git commit -m 'Add some AmazingFeature'`)
4.  Push to the branch (`git push origin feature/AmazingFeature`)
5.  Open a Pull Request

## Resources

- [Flutter Documentation](https://docs.flutter.dev)
- [Flutter Codelab](https://docs.flutter.dev/get-started/codelab)
- [Flutter Cookbook](https://docs.flutter.dev/cookbook)
