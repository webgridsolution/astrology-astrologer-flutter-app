#!/usr/bin/env bash
set -euo pipefail
cd "$(dirname "$0")"
echo "Generating Android / iOS / Web platform folders (does not overwrite lib/)..."
flutter create . --project-name astroguide_astrologer --org com.webgrid.astrochat --platforms=android,ios,web
flutter pub get
echo
echo "Ready. Run: flutter run"
echo "Demo OTP: 123456"
