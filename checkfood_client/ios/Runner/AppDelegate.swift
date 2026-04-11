import Flutter
import UIKit
import GoogleMaps

@main
@objc class AppDelegate: FlutterAppDelegate {

  /// Method channel shared with `lib/security/presentation/utils/secure_screen.dart`.
  /// iOS doesn't expose an equivalent to Android's FLAG_SECURE, so we
  /// emulate the same UX by covering the app with a blurred overlay in
  /// `applicationWillResignActive` — this renders the task-switcher
  /// thumbnail as an opaque blur instead of the actual password / OTP
  /// field content.
  private let secureChannel = "com.checkfood.checkfood_client/secure_screen"
  private let integrityChannel = "com.checkfood.checkfood_client/device_integrity"
  private var sensitiveRouteActive = false
  private var blurView: UIVisualEffectView?

  /// Paths that commonly exist on jailbroken devices. Any single hit is
  /// a strong signal. The list intentionally excludes `/bin/bash` and
  /// `/usr/sbin/sshd` — those also exist on the iOS Simulator and
  /// would false-positive the CI sim.
  private let jailbreakArtifacts: [String] = [
    "/Applications/Cydia.app",
    "/Applications/Sileo.app",
    "/Library/MobileSubstrate/MobileSubstrate.dylib",
    "/etc/apt",
    "/private/var/lib/apt/",
    "/private/var/stash",
    "/var/cache/apt",
    "/var/lib/cydia",
    "/var/tmp/cydia.log"
  ]

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

    if let controller = window?.rootViewController as? FlutterViewController {
      let secureCh = FlutterMethodChannel(
        name: secureChannel,
        binaryMessenger: controller.binaryMessenger
      )
      secureCh.setMethodCallHandler { [weak self] call, result in
        guard let self = self else { return }
        switch call.method {
        case "enable":
          self.sensitiveRouteActive = true
          result(nil)
        case "disable":
          self.sensitiveRouteActive = false
          self.removeBlur()
          result(nil)
        default:
          result(FlutterMethodNotImplemented)
        }
      }

      let integrityCh = FlutterMethodChannel(
        name: integrityChannel,
        binaryMessenger: controller.binaryMessenger
      )
      integrityCh.setMethodCallHandler { [weak self] call, result in
        guard let self = self else { return }
        switch call.method {
        case "isCompromised":
          result(self.detectJailbreak())
        default:
          result(FlutterMethodNotImplemented)
        }
      }
    }

    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }

  /// Lightweight jailbreak heuristic. Returns true on any hit. Only
  /// checks filesystem paths + a sandbox-escape write; doesn't use any
  /// private APIs so App Store review won't flag it.
  private func detectJailbreak() -> Bool {
    #if targetEnvironment(simulator)
      return false
    #else
      let fm = FileManager.default
      for path in jailbreakArtifacts {
        if fm.fileExists(atPath: path) {
          return true
        }
      }
      // Sandbox escape: try to write outside the app container.
      let probe = "/private/jailbreak_probe_\(UUID().uuidString).txt"
      do {
        try "x".write(toFile: probe, atomically: true, encoding: .utf8)
        try? fm.removeItem(atPath: probe)
        return true // Should never succeed on a non-jailbroken device.
      } catch {
        return false
      }
    #endif
  }

  override func applicationWillResignActive(_ application: UIApplication) {
    super.applicationWillResignActive(application)
    if sensitiveRouteActive { addBlur() }
  }

  override func applicationDidBecomeActive(_ application: UIApplication) {
    super.applicationDidBecomeActive(application)
    removeBlur()
  }

  private func addBlur() {
    guard let window = self.window, blurView == nil else { return }
    let effect = UIBlurEffect(style: .systemUltraThinMaterial)
    let view = UIVisualEffectView(effect: effect)
    view.frame = window.bounds
    view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
    window.addSubview(view)
    blurView = view
  }

  private func removeBlur() {
    blurView?.removeFromSuperview()
    blurView = nil
  }
}
