# AstroChat Astrologer Partner App

Premium Flutter partner console for astrologers on the **AstroChat** platform.

**POWERED BY Webgrid Solution**

## Features

- Splash + login state
- Mobile + OTP login (`123456`)
- Astrologer registration (name, mobile, email, experience, languages, specializations, about)
- Dashboard with earnings line chart and booking donut
- Online / offline toggle
- Bookings, booking details, sessions, session summary
- WhatsApp-style chat
- Mock audio call, video call, incoming call
- Services (add / edit / enable)
- Earnings + payouts
- Reviews with reply
- Availability calendar
- Profile, edit profile, KYC
- Clients, private notes, **client Kundli**
- Notifications, settings, help, logout
- SharedPreferences session
- MVC + Provider, mock repositories ready for APIs

## Run

Requires [Flutter](https://docs.flutter.dev/get-started/install) 3.22+.

```bash
cd astroguide_astrologer
flutter create . --project-name astroguide_astrologer --org com.webgrid.astrochat
flutter pub get
flutter run
```

`flutter create .` only generates missing Android / iOS / web folders and will not overwrite `lib/` or `pubspec.yaml`.

## Demo credentials

- Any 10-digit mobile number
- OTP: **123456**

Or tap **Register here**, fill the astrologer form, then verify with the same OTP. Saved details appear on Dashboard and Profile.

## Architecture

```
lib/
  models/        domain models
  mock/          seed data
  services/      SharedPreferences + MockDataService
  controllers/   ChangeNotifier (MVC)
  views/         screens
  widgets/       reusable UI
  utils/         theme, colors, routes
```

Swap `MockDataService` for real Auth / Booking / Chat / Call / Payment APIs later. Call screens are UI-ready for Agora, Twilio or WebRTC.

## Brand

Purple / lavender / white / gold, light premium theme, consistent with the AstroChat customer app.
