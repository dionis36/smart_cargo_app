# Smart Cargo Mobile App

![Flutter](https://img.shields.io/badge/Flutter-%2302569B.svg?style=for-the-badge&logo=Flutter&logoColor=white)
![Dart](https://img.shields.io/badge/dart-%230175C2.svg?style=for-the-badge&logo=dart&logoColor=white)
![Status](https://img.shields.io/badge/Status-In%20Development-yellow?style=for-the-badge)

> [!IMPORTANT]
> **App Status**: The Smart Cargo app is currently in development and has not yet been deployed to public app stores.

Smart Cargo is a delivery service mobile application that connects retailers and individual users with drivers to provide fast, reliable, and cost-efficient delivery of goods and parcels. The app targets common logistics problems such as high delivery costs, long delays, and unreliable service.

---

## Table of Contents

- [Features](#features)
- [Screenshots](#screenshots)
- [Technology Stack](#technology-stack)
- [Getting Started](#getting-started)
- [Request Flow & Pricing](#request-flow--pricing-algorithm)
- [Multilingual Support](#multilingual-support)
- [User Accounts & Terms](#user-accounts--terms)
- [Contributing](#contributing)
- [Team](#team)
- [License](#license)
- [Contact](#contact)

---

## Features

- **Multilingual Support**: Language preference available for **Swahili** and **English**, implemented app-wide.
- **Real-Time Tracking**: Track deliveries using a unique order number.
- **Delivery Request Flow**:
  - Specify pickup and destination locations.
  - Describe parcel by category, fragility, size, weight, and value.
  - Select transport option (Bike, Motorbike, Car, Van).
- **Smart Pricing**: Automatic recommendations and price calculation based on parcel attributes and distance.
- **User Account**: Profile management and integrated Terms & Conditions.

## Screenshots

| Home | Request Flow |
|:---:|:---:|
| ![Home Screen](https://github.com/user-attachments/assets/ff8d09ca-0c93-4f27-8535-8be945888fbc) | ![Request Flow 1](https://github.com/user-attachments/assets/2261f393-2351-4c16-89b2-61989df7e0c3) |
| **Request Flow (Details)** | **Account & Settings** |
| ![Request Flow 2](https://github.com/user-attachments/assets/5c27379a-70d5-40e1-aa6d-d86a33b3df19) | ![Settings](https://github.com/user-attachments/assets/f698e3fa-5c60-45a0-9236-490e282eed94) |

## Technology Stack

| Category | Technology | Description |
|----------|------------|-------------|
| **Framework** | Flutter (Dart) | Cross-platform mobile development |
| **Backend** | Django | Backend services and API |
| **AI Services** | ChatGPT | Customer support prompts |
| **Design** | Lovable.ai | Design and marketing helpers |
| **Maps** | OpenStreetMap API | Address input and geocoding |
| **CI/CD** | TBD | GitHub Actions / Codemagic (Planned) |

## Getting Started

### Prerequisites

- **Flutter SDK** (stable channel)
- **VS Code** or **Android Studio** with Flutter extensions
- Android/iOS Emulator or Physical Device

### Installation

1. **Clone the repository**
   ```bash
   git clone https://github.com/dionis36/smart-cargo-app.git
   cd smart-cargo-app
   ```

2. **Install dependencies**
   ```bash
   flutter pub get
   ```

### Configuration

1. **Firebase Setup**:
   - Create a Firebase project.
   - Add Android (`google-services.json`) to `android/app/`.
   - Add iOS (`GoogleService-Info.plist`) to `ios/Runner/`.

2. **Environment Variables**:
   Create a `.env` file or use `--dart-define`:
   ```env
   OPENSTREETMAP_USER_AGENT=SmartCargoApp/1.0
   TERMS_URL=https://your-termly-url
   ```

### Running the App

```bash
# Run on connected device
flutter run

# Build for release
flutter build apk --release
```

## Request Flow & Pricing Algorithm

### User Flow
1. **Pickup & Destination**: Select locations via map or address search.
2. **Parcel Details**: Input category, fragility, dimensions, weight, and value.
3. **Transport Selection**: App suggests vehicle type (Bike, Motorbike, Car, Van).
4. **Confirmation**: Review estimated price and confirm.

### Pricing Logic
- **Base Price**: Varies by transport type.
- **Distance**: Price increases with distance.
- **Multipliers**: Weight, volume, and fragility add surcharges.
- **Insurance**: Optional percentage fee for high-value items.

## Multilingual Support

- Toggles between **English** and **Swahili**.
- Strings managed via localized resource files.

## User Accounts & Terms

- **Authentication**: Firebase Auth (Email/Phone).
- **Terms**: Integrated via Termly.io.

## Contributing

We welcome contributions!

1. Fork the repository.
2. Create a feature branch: `git checkout -b feature/amazing-feature`.
3. Commit changes and open a Pull Request.

## Team

| Name | Role |
|------|------|
| **George Rashid** | Product Manager |
| **Alen Alen** | UX/UI Designer |
| **Nobert John** | Backend Engineer |
| **Dionis Nasuwa** | Lead Flutter Developer |
| **Riffat Ali** | QA & DevOps |

## License

**TBD**. A `LICENSE` file will be added soon.

## Contact

For questions or collaboration, reach out to the project owner:
[GitHub Profile](https://github.com/dionis36)

---
*Last updated: 18/09/2025*
