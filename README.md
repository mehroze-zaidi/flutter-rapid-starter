# flutter_rapid_starter

A Flutter project template to help you start building apps faster. Includes routing, networking, secure storage, localization, responsive layout, theming, dark mode color system, and helper scripts — all pre-configured.

---

## What's Included

| Package | Purpose |
|---|---|
| `go_router` | Declarative routing and navigation |
| `dio` | HTTP client for API requests |
| `connectivity_plus` | Detect network connectivity changes |
| `flutter_secure_storage` | Secure key-value storage |
| `easy_localization` | Multi-language support |
| `flutter_screenutil` | Responsive sizing across screen sizes |
| `lottie` | Lottie animation support |
| `logger` | Structured console logging |
| `change_app_package_name` | CLI: change Android/iOS bundle ID |
| `rename_app` | CLI: change app display name |

---

## Project Structure

```
lib/
├── main.dart
├── core/
│   ├── common_widgets/       # Reusable widgets (RoundedContainer, ErrorState)
│   ├── constants/            # Colors, theme, strings, app constants
│   ├── extensions/           # Dart extensions (spacing helpers)
│   ├── services/             # ConnectivityService, SecureStorageService
│   └── utils/                # SnackbarHelper
├── data/
│   ├── api_response.dart     # ApiResponse<T> sealed class (Success / Failure)
│   ├── network/              # ApiClient, interceptors (auth, error, logging)
│   └── repository_imp/       # Local and remote repository implementations
└── presentation/
    ├── app/                  # App entry widget and initializer
    ├── router/               # GoRouter config (AppRouter, AppRoutes)
    └── screens/
        ├── splash/           # Splash screen — checks onboarding flag
        ├── onboarding/       # 3-slide onboarding flow with dot indicators
        ├── no_connection/    # No-internet screen with retry
        └── home/             # Home screen
```

---

## Getting Started

**Prerequisites:** Flutter SDK `^3.5.0`, Dart SDK `^3.5.0`

```bash
# 1. Clone the repo
git clone <repo-url>
cd flutter_rapid_starter

# 2. Install dependencies
flutter pub get

# 3. Run the app
flutter run
```

---

## Customize Your App

Follow these steps in order after cloning:

### 1. Rename the Dart package

Updates the `name:` field in `pubspec.yaml` and all `package:` imports across `lib/`.

```bash
bash scripts/rename_package.sh my_app
```

### 2. Change the bundle ID / app package name

Updates the Android package name and iOS bundle identifier.

```bash
dart run change_app_package_name:main com.company.appname
```

### 3. Rename the app display name

Changes the name shown on the device home screen.

```bash
dart run rename_app:main all="My App Name"
```

### 4. Generate app icons

Place your logo at `assets/app_logo/app_logo.png` then run:

```bash
dart run flutter_scripts:main generate_icons
```

The icon config in `pubspec.yaml` uses an adaptive icon with a white background. Adjust `flutter_icons:` section as needed.

### 5. Set up translations

Translation files are at `assets/translations/`. Five languages are pre-configured: `en`, `ar`, `fr`, `es`, `it`. Add or remove files as needed:

```
assets/translations/
├── en.json
├── ar.json
├── fr.json
├── es.json
└── it.json
```

`easy_localization` is already initialized in `main.dart` and wrapped in the root widget. Add your keys to `AppStrings` and the JSON files, then use `.tr()` in your widgets.

---

## Colors & Dark Mode

Colors are split into two layers:

**`AppColors`** — pure `const` static tokens, grouped by purpose:

```dart
// Brand
AppColors.primary          // main brand color
AppColors.primary50        // tinted brand surface

// Semantic states
AppColors.error / error50
AppColors.success / success50
AppColors.warning
AppColors.info / info50

// Surfaces
AppColors.surfaceWhite
AppColors.darkBackground
AppColors.darkCardBackground

// Typography
AppColors.headingText / labelText / textParagraph / hintColor

// Neutral scale
AppColors.natural100 / 300 / 500 / 700 / 950

// UI elements
AppColors.stroke / buttonStroke / inputSurface
```

**`AppColorScheme`** — context-aware getters that automatically resolve to light or dark values. Access via the `BuildContext` extension:

```dart
// In any widget:
Container(color: context.colors.backgroundCard)
Text('Hello', style: TextStyle(color: context.colors.headingText))
```

Available getters: `backgroundMain`, `backgroundMainWhite`, `backgroundCard`, `backgroundCardWhite`, `opposite`, `theme`, `headingText`, `bodyText`, `grayText`, `buttonStroke`, `stroke`, `primary50`, `natural100`.

Dark mode is driven by `MaterialApp`'s `theme` / `darkTheme` — no manual calls needed. Toggle it by changing the system appearance or passing `themeMode` to `MaterialApp.router`.

---

## Available Scripts

Run via `dart run flutter_scripts:main <script>` or directly with `bash`:

| Script | Command | Description |
|---|---|---|
| `rename_package` | `bash scripts/rename_package.sh <name>` | Rename Dart package name |
| `regen_platforms` | `bash scripts/regen_platforms.sh --confirm` | Regenerate android/ and ios/ from scratch |
| `generate_icons` | `flutter pub run flutter_launcher_icons` | Generate app launcher icons |
| `generate_files` | `dart run build_runner build --delete-conflicting-outputs` | Run code generation |
| `watch` | `dart run build_runner watch --delete-conflicting-outputs` | Watch and regenerate on change |
| `buildApk` | `flutter clean && flutter build apk` | Build release APK |
| `buildAbb` | `flutter clean && flutter build appbundle` | Build release App Bundle |

---

## Regenerate Native Platforms

Use this to keep Android (Gradle, Kotlin, AGP) and iOS (Swift, Xcode tooling) versions up to date by regenerating them from the latest Flutter templates.

```bash
# Preview what will happen (no changes made)
bash scripts/regen_platforms.sh

# Run the regeneration with default org (com.example)
bash scripts/regen_platforms.sh --confirm

# Run with a custom org
bash scripts/regen_platforms.sh --confirm com.yourorg
```

After regenerating, re-apply your bundle ID and app name (steps 2 and 3 above).

---

## Onboarding

A 3-slide onboarding flow is included and shown on the first app launch.

**How it works:**
- Shown once — on completion, writes a flag to `flutter_secure_storage` so it's never shown again
- Each slide has an icon, title, and description — all sourced from `AppStrings` (localization-ready)
- Skip button available on every slide
- Dot indicators + Next / Get Started button at the bottom

**To customize the slides**, edit the `_pages` list in `onboarding_screen.dart`:

```dart
// lib/presentation/screens/onboarding/onboarding_screen.dart
(
  title: AppStrings.onboardingTitle1.tr(),
  description: AppStrings.onboardingDesc1.tr(),
  icon: Icons.waving_hand_outlined,
),
```

Update the string keys in `AppStrings` and your translation JSON files to change the text.

---

## Architecture

| Layer | Path | Responsibility |
|---|---|---|
| Core | `lib/core/` | Shared constants, widgets, extensions, services |
| Data | `lib/data/` | Repository pattern, networking, API response model |
| Presentation | `lib/presentation/` | Screens, app widget, navigation |

---

## Fonts

The Cairo font family is pre-configured and ready to use:

| Weight | Name |
|---|---|
| 200 | ExtraLight |
| 300 | Light |
| 400 | Regular |
| 500 | Medium |
| 600 | SemiBold |
| 700 | Bold |
| 800 | ExtraBold |

```dart
TextStyle(fontFamily: 'Cairo', fontWeight: FontWeight.w600)
```
