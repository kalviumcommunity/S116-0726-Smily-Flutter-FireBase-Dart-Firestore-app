# 🛺 UnionRide

> **Automated Auto & Cab On-Demand Dispatch Platform** | Team Smily (Sprint 2 Ecosystem, August 2026)

[![Flutter](https://img.shields.io/badge/Flutter-02569B?style=flat-square&logo=flutter&logoColor=white)](https://flutter.dev)
[![Dart](https://img.shields.io/badge/Dart-0175C2?style=flat-square&logo=dart&logoColor=white)](https://dart.dev)
[![Firebase](https://img.shields.io/badge/Firebase-FFCA28?style=flat-square&logo=firebase&logoColor=black)](https://firebase.google.com)

---

## 📌 Overview & Target KPIs

UnionRide modernizes regional auto-rickshaw & cab union operations, replacing manual radio dispatching with real-time driver-passenger matching, transparent queues, and zonal demand analytics.

| Metric (KPI) | Baseline (Radio) | Target (UnionRide) |
| :--- | :--- | :--- |
| **Dispatch Latency** | 4 – 8 mins | **< 30 seconds** |
| **Call Fulfillment Rate** | ~65% | **> 95%** |
| **Data Logging** | 0% (Verbal) | **100% Automated** |
| **Driver Allocation** | Voice-first skew | **Proximity matching** |
| **Demand Intelligence** | None | **Zonal Heatmap** |

---

## 📱 Features & UI Screens

### 🔐 Authentication & Onboarding (`lib/features/auth`)
- **Splash Screen (`splash_screen.dart`):** Animated initial splash with automated auth checking and role-based redirect.
- **Role Selection (`role_selection_screen.dart`):** Interactive choice between Passenger and Driver flows.
- **Login (`login_screen.dart`):** User authentication with email/password and Firebase Auth integration.
- **Passenger Registration (`rider_register_screen.dart`):** Signup form for passengers with profile inputs.
- **Driver Registration (`driver_register_screen.dart`):** Form for drivers with vehicle details, union permit ID, and license details.
- **Password Recovery (`forgot_password_screen.dart` & `reset_password_screen.dart`):** Complete flow for password reset emails and link verification.

### 🚗 Passenger Ecosystem (`lib/features/passenger`)
- **Passenger Home (`passenger_home_screen.dart`):** Main dashboard with ride options, active booking status, and quick navigation.
- **Ride Search (`search_ride_screen.dart`):** Pickup and drop-off location selection interface.
- **Ride Results & Fare Estimation (`ride_results_screen.dart`):** Compare vehicle tiers (Auto / Cab / Mini Auto) with instant fare calculation.
- **Live Ride Details & Tracking (`ride_details_screen.dart`):** Real-time trip status, driver details, fare breakdown, and action controls.
- **Ride History (`my_rides_screen.dart`):** Comprehensive view of past, ongoing, and cancelled trips.
- **Passenger Profile (`rider_profile_screen.dart`):** Profile management, emergency contacts, saved places, and account settings.

### 🚕 Driver Ecosystem (`lib/features/driver`)
- **Driver Dashboard (`driver_dashboard`):** Online/Offline availability toggle, incoming dispatch offer notifications, trip acceptance, and zonal queue status *(Under Active Development)*.

---

## 📁 Project Architecture & Directory Structure

```text
lib/
├── app/                  # App initialization & global configurations
├── core/                 # Design system, themes (AppTheme), constants, & helpers
├── features/             # Feature-first modular structure
│   ├── admin/            # Fleet monitoring & zonal analytics dashboards
│   ├── auth/             # Authentication screens & auth widgets
│   ├── driver/           # Driver dispatch screens & dashboard
│   └── passenger/        # Passenger home, ride booking, search, history & profile
├── models/               # Data transfer objects & Firestore schemas (UserModel, etc.)
├── routes/               # AppRoutes & AppRouter setup with Named Route Navigation
├── services/             # Firebase Authentication, Firestore, & backend services
└── shared/               # Reusable UI widgets & common utilities
```

---

## 🛠 Tech Stack

- **Frontend:** Flutter & Dart (Cross-platform native UI, 60fps)
- **Authentication:** Firebase Auth (Email/Password, Phone OTP & Role-Based Access Control)
- **Database:** Cloud Firestore (Real-time NoSQL database with reactive listeners)
- **Storage:** Firebase Storage (Driver Licenses, RC, Permits, Avatars)
- **Navigation:** Centralized `AppRouter` with named routes

---

## 🗄 Cloud Firestore Schema

- `users/{uid}`: `fullName`, `phoneNumber`, `role`, `createdAt`, `isActive`
- `drivers/{uid}`: `vehicleType` (auto/cab), `vehicleRegistrationNumber`, `unionPermitNumber`, `isOnline`, `isBusy`, `currentZone`
- `rides/{rideId}`: `passengerId`, `driverId`, `vehicleType`, `pickupLocation`, `dropoffLocation`, `zoneId`, `fareEstimate`, `status`, `completedAt`
- `zones/{zoneId}`: `zoneName`, `activeDriversCount`, `pendingRequestsCount`, `totalCompletedToday`, `lastUpdated`

---

## 🔄 Ride State Machine & Security

### State Flow
`PENDING` → `ACCEPTED` → `ARRIVED` → `IN_TRANSIT` → `COMPLETED` *(or `CANCELLED`)*

> 🔒 **Atomic Transactions:** Accepts verify `status == PENDING` in a single transaction to prevent race conditions across concurrent driver acceptances.

### Access Control & Storage Asset Mapping
- **Storage:** `/users/{uid}/avatar.jpg`, `/drivers/{driverId}/license.jpg`, `/drivers/{driverId}/rc_permit.pdf`
- **Security Matrix:** Profile Owner write (`users`), Driver/Admin write (`drivers`), Assigned Passenger/Driver/Admin write (`rides`).

---

## 🗓 Delivery Roadmap

1. **Sprint 1 (Foundation):** Setup, Phone/Email Auth, Profiles & Architecture setup. ✅
2. **Sprint 2 (Passenger & Core UI Flow - Current):** Auth screens, Passenger Dashboard, Ride Search & Booking Results, Trip Details & Rider Profile. 🚀
3. **Sprint 3 (Driver Dispatch & Admin Analytics):** Real-time Dispatch engine, Unassigned Queue Override, Fleet Monitor & Zonal Demand Heatmap. ⏳

---

## 🚀 Quick Start

```bash
# 1. Clone & install dependencies
git clone https://github.com/kalviumcommunity/S116-0726-Smily-Flutter-FireBase-Dart-Firestore-app.git
cd S116-0726-Smily-Flutter-FireBase-Dart-Firestore-app
flutter pub get

# 2. Configure Firebase & run emulators
flutterfire configure
firebase emulators:start

# 3. Launch App
flutter run
```
