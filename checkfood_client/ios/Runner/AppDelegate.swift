import Flutter
import UIKit
import GoogleMaps

@main
@objc class AppDelegate: FlutterAppDelegate {
  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
    // Google Maps key is injected at build time via `ios/Flutter/Secrets.xcconfig`
    // (gitignored) using `MAPS_API_KEY=...`. The value propagates through
    // `Debug.xcconfig` / `Release.xcconfig` into `Info.plist` under the
    // `GMSApiKey` entry and is read here at runtime.
    // If missing, Maps features will fail at first use with a clear error —
    // never hardcode the key in source.
    if let apiKey = Bundle.main.object(forInfoDictionaryKey: "GMSApiKey") as? String,
       !apiKey.isEmpty {
      GMSServices.provideAPIKey(apiKey)
    } else {
      NSLog("[CheckFood] WARNING: GMSApiKey missing from Info.plist — Maps SDK will fail. Set MAPS_API_KEY in ios/Flutter/Secrets.xcconfig.")
    }
    GeneratedPluginRegistrant.register(with: self)
    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }
}
