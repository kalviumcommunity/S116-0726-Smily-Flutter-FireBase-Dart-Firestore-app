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

## 👤 User Roles

- **Passenger:** One-tap booking (Auto/Cab), upfront fare & ETA, live status tracking, trip history.
- **Driver:** Online/Offline toggle, incoming offer popup (15s timer), trip controls (`Arrived` → `Start` → `Complete`), document uploads.
- **Dispatcher / Admin:** Unassigned request queue (>60s pending), manual phone-booking override, live fleet & zonal analytics dashboard.

---

## 🛠 Tech Stack

- **Frontend:** Flutter & Dart (Cross-platform native UI, 60fps)
- **Authentication:** Firebase Auth (Phone OTP & RBAC)
- **Database:** Cloud Firestore (Real-time NoSQL, reactive listeners)
- **Storage:** Firebase Storage (Driver Licenses, RC, Permits, Avatars)

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

1. **Sprint 1 (Foundation):** Setup, Phone Auth, Profiles & Document Storage.
2. **Sprint 2 (Core Dispatch Loop - Current):** Booking Engine, Driver Offer Popup, Atomic Assignment, Trip Lifecycle.
3. **Sprint 3 (Admin & Analytics):** Unassigned Queue Override, Fleet Monitor & Zonal Demand Heatmap.

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
