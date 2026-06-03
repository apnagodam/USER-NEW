#!/bin/bash

echo "🍎 Fixing iOS APNS Entitlements Configuration..."

# Navigate to iOS directory
cd ios

echo "📝 Cleaning iOS build..."
rm -rf build/
rm -rf Pods/
rm -rf .symlinks/
rm -rf Flutter/ephemeral/
rm -rf DerivedData/

echo "🔧 Installing pods..."
pod install --repo-update

echo "✅ iOS configuration updated!"
echo ""
echo "📋 Next steps:"
echo "1. Open ios/Runner.xcworkspace in Xcode"
echo "2. Select Runner target"
echo "3. Go to 'Signing & Capabilities' tab"
echo "4. Add 'Push Notifications' capability if not present"
echo "5. Verify entitlements file is linked:"
echo "   - Debug: Runner/Runner.entitlements"
echo "   - Release: Runner/Release.entitlements"
echo "6. Build and run on a real iOS device"
echo ""
echo "⚠️  Remember: APNS only works on real iOS devices, not simulator!"