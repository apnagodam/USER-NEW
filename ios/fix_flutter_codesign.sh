#!/bin/bash
# Fix Flutter codesigning issue for simulator builds

FLUTTER_FRAMEWORK="${BUILD_DIR}/${CONFIGURATION}-iphonesimulator/Flutter.framework/Flutter"

if [ -f "$FLUTTER_FRAMEWORK" ]; then
    echo "Removing codesign from Flutter framework..."
    codesign --remove-signature "$FLUTTER_FRAMEWORK" 2>/dev/null || true
    echo "Codesign removed successfully"
fi

exit 0
