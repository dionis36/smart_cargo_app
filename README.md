# Smart Cargo Mobile App

Smart Cargo is a delivery service mobile application that connects retailers and individual users with drivers to provide fast, reliable, and cost-efficient delivery of goods and parcels. The app targets common logistics problems such as high delivery costs, long delays, and unreliable service.

---

## Table of contents

* [Features](#features)
* [Screenshots](#screenshots)
* [Technology Stack](#technology-stack)
* [Getting Started](#getting-started)

  * [Prerequisites](#prerequisites)
  * [Clone & Install](#clone--install)
  * [Firebase & Environment setup](#firebase--environment-setup)
  * [Run the app](#run-the-app)
* [Request Flow & Pricing Algorithm](#request-flow--pricing-algorithm)
* [Multilingual Support](#multilingual-support)
* [User Accounts & Terms](#user-accounts--terms)
* [Contributing](#contributing)
* [Team](#team)
* [License](#license)
* [Contact](#contact)

---

## Features

* **Multilingual Support** — Language preference available for **Swahili** and **English**, implemented app-wide.
* **Real-Time Tracking** — Track deliveries using a unique order number (provided on confirmation).
* **Delivery Request Flow** — Multi-step flow to request deliveries:

  * Specify pickup and destination locations.
  * Describe parcel by category, fragility, size, weight, and value.
  * Select transport option — calculated by an internal pricing algorithm that considers weight, size, and distance.
* **Transport Selection & Pricing** — Automatic recommendations and price calculation based on parcel attributes and distance.
* **User Account & Settings** — Profile management and integrated **Terms & Conditions** (generated with Termly.io).

## Screenshots

*  — Home
  
![WhatsApp Image 2025-08-27 at 00 19 56_fcd25ef0](https://github.com/user-attachments/assets/ff8d09ca-0c93-4f27-8535-8be945888fbc)

* Request flow
  
![WhatsApp Image 2025-09-10 at 11 02 43_2b9fbde8](https://github.com/user-attachments/assets/2261f393-2351-4c16-89b2-61989df7e0c3)

![WhatsApp Image 2025-09-10 at 11 02 43_f2acf7e8](https://github.com/user-attachments/assets/5c27379a-70d5-40e1-aa6d-d86a33b3df19)

* Account & Settings
  
![WhatsApp Image 2025-08-27 at 00 19 57_decd225c](https://github.com/user-attachments/assets/f698e3fa-5c60-45a0-9236-490e282eed94)



## Technology Stack

* **Framework:** Flutter (Dart)
* **Backend & Services:** Django, ChatGPT (for customer support / prompts), Lovable.ai (design/marketing helpers)
* **Maps / Location:** OpenStreetMap API (for address input and geocoding)
* **CI / CD:** (TBD — e.g. GitHub Actions / Codemagic)

## Getting Started

### Prerequisites

* Flutter SDK (stable channel) installed — follow Flutter docs for platform setup.
* VS Code / Android Studio with Flutter extensions (recommended).
* Android or iOS emulator, or a physical device.

### Clone & Install

```bash
# clone the repo
git clone https://github.com/your-username/smart-cargo-app.git
cd smart-cargo-app

# install dependencies
flutter pub get
```

### Firebase & Environment setup

This app expects a Firebase project for authentication, Firestore, Cloud Functions (optional) and storage.

1. Create a Firebase project at the Firebase console.
2. Add Android and/or iOS app in Firebase. Download `google-services.json` (Android) and/or `GoogleService-Info.plist` (iOS) and place them in the respective platform folders: `android/app/` and `ios/Runner/`.
3. In Firestore, configure the following collections (suggested):

   * `users` — user profiles and preferences
   * `orders` — delivery requests and status updates
   * `drivers` — driver profiles and availability
4. Add required API keys and config variables to `.env` or use `--dart-define`.

**Example `.env` keys** (or use your preferred approach — `flutter_dotenv`,  `--dart-define`):

```
OPENSTREETMAP_USER_AGENT=SmartCargoApp/1.0
TERMS_URL=https://your-termly-url
```

> Security note: Do **not** commit secrets to version control. Use environment variables or secret manager.

### Run the app

```bash
# run on connected device or emulator
flutter run

# or build for release
flutter build apk --release
```

## Request Flow & Pricing Algorithm

Request flow summary (user-facing):

1. User chooses **Pickup** location (map or typed address).
2. User chooses **Destination** location.
3. User selects parcel attributes:

   * Category (documents, food, clothing, electronics, etc.)
   * Fragility (fragile / not fragile)
   * Size / dimensions
   * Weight
   * Declared value
4. App suggests transport options (bike, motorbike, car, van) and an estimated price based on the algorithm.

**Pricing algorithm (high-level):**

* Base price by transport type (e.g., bike < motorbike < car < van).
* Distance factor: price ∝ distance.
* Weight/volume multiplier: heavier/larger items increase cost.
* Fragility / handling surcharge if `fragile == true`.
* Insurance fee for high-value items (optional, percentage-based).

## Multilingual Support

* The app contains a language preference which toggles between English and Swahili.
* Strings are kept in localized resource files (e.g., `lib/l10n/` or use `easy_localization` / `intl`).

## User Accounts & Terms

* Users can create an account using Firebase Authentication (email/phone).
* Terms & Conditions are integrated and loaded from the Termly.io link (or local copy for offline viewing).

## Contributing

We welcome contributions!

1. Fork the repository.
2. Create a feature branch: `git checkout -b feature/your-feature`.
3. Commit changes and open a Pull Request.

Please include:

* Clear PR description
* Screenshots for UI changes
* Tests for logic-heavy changes

## Team

* **George Rashid** — Product Manager
* **Alen Alen** — UX/UI Designer
* **Nobert John** — Backend Engineer (Firebase)
* **Dionis Nasuwa** — Lead Flutter Developer
* **Riffat Ali** — QA & DevOps


## License

License: **To be determined**. Add a `LICENSE` file at the repository root when you decide. A common choice is the MIT License — if you want, I can add an MIT license template.

## App Status

> The Smart Cargo app is currently in development and has not yet been deployed to public app stores.

## Contact

For questions or collaboration, open an issue or reach out to the project owner on GitHub: `https://github.com/dionis36`.

---

*Last updated: 18/09/2025*
