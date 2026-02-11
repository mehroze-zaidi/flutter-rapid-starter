#!/bin/bash
set -e

# Regenerates android/ and ios/ directories from scratch using the latest Flutter templates.
# Run this periodically to keep Gradle, Kotlin, AGP, and Swift tooling versions up to date.
#
# Usage:
#   bash scripts/regen_platforms.sh              # uses default org: com.example
#   bash scripts/regen_platforms.sh com.yourorg  # uses a custom org

ORG="${1:-com.example}"
PROJECT_DIR="$(cd "$(dirname "$0")/.." && pwd)"

echo "-------------------------------------------"
echo " Flutter Platform Regeneration"
echo "-------------------------------------------"
echo " Project : $PROJECT_DIR"
echo " Org     : $ORG"
echo ""
echo " This will DELETE android/ and ios/ and recreate them from the latest Flutter templates."
echo ""
echo " [y] Yes, delete and regenerate"
echo " [N] No, abort"
printf " Your choice: "
read confirm
if [[ "$confirm" != "y" && "$confirm" != "Y" ]]; then
  echo "Aborted."
  exit 0
fi

echo ""
echo "[1/3] Removing android/ and ios/ ..."
rm -rf "$PROJECT_DIR/android" "$PROJECT_DIR/ios"

echo "[2/3] Regenerating from latest Flutter templates ..."
cd "$PROJECT_DIR" && flutter create . --org "$ORG" --platforms android,ios

echo "[3/3] Running flutter pub get ..."
flutter pub get

echo ""
echo "Done!"
echo ""
echo "Next steps:"
echo "  • Set your package name : dart run change_app_package_name:main com.your.package.name"
echo "  • Set your app name     : dart run rename_app:main all=\"My App Name\""
