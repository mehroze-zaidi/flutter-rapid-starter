#!/bin/bash
set -e

# Renames the Dart package name in pubspec.yaml and updates all package: imports across lib/.
#
# Usage:
#   bash scripts/rename_package.sh <new_package_name>
#
# Example:
#   bash scripts/rename_package.sh my_app

NEW_NAME="$1"
PROJECT_DIR="$(cd "$(dirname "$0")/.." && pwd)"
PUBSPEC="$PROJECT_DIR/pubspec.yaml"

if [ -z "$NEW_NAME" ]; then
  echo "Error: No package name provided."
  echo ""
  echo "Usage: bash scripts/rename_package.sh <new_package_name>"
  echo "Example: bash scripts/rename_package.sh my_app"
  exit 1
fi

# Extract current name from pubspec.yaml
OLD_NAME=$(grep -E '^name:' "$PUBSPEC" | sed 's/name: *//' | tr -d '[:space:]')

if [ -z "$OLD_NAME" ]; then
  echo "Error: Could not read current package name from pubspec.yaml."
  exit 1
fi

if [ "$OLD_NAME" = "$NEW_NAME" ]; then
  echo "Package name is already '$NEW_NAME'. Nothing to do."
  exit 0
fi

echo "-------------------------------------------"
echo " Rename Dart Package"
echo "-------------------------------------------"
echo " Old name : $OLD_NAME"
echo " New name : $NEW_NAME"
echo ""

# Update name in pubspec.yaml
sed -i '' "s/^name: $OLD_NAME/name: $NEW_NAME/" "$PUBSPEC"
echo "[1/3] Updated name in pubspec.yaml"

# Update all package: imports in lib/
find "$PROJECT_DIR/lib" -name "*.dart" \
  -exec sed -i '' "s/package:$OLD_NAME\//package:$NEW_NAME\//g" {} \;
echo "[2/3] Updated package imports in lib/"

# Update imports in test/ if it exists
if [ -d "$PROJECT_DIR/test" ]; then
  find "$PROJECT_DIR/test" -name "*.dart" \
    -exec sed -i '' "s/package:$OLD_NAME\//package:$NEW_NAME\//g" {} \;
  echo "[2/3] Updated package imports in test/"
fi

# Restore dependencies
echo "[3/3] Running flutter pub get ..."
cd "$PROJECT_DIR" && flutter pub get

echo ""
echo "Done! Package renamed from '$OLD_NAME' to '$NEW_NAME'."
