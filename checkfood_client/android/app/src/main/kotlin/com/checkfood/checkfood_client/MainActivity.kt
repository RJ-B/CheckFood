package com.checkfood.checkfood_client

import android.os.Build
import android.os.Bundle
import android.view.WindowManager
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel
import java.io.File

class MainActivity : FlutterActivity() {

    /**
     * Method channel used by `lib/security/presentation/utils/secure_screen.dart`
     * to toggle `WindowManager.LayoutParams.FLAG_SECURE` on sensitive screens.
     *
     * FLAG_SECURE prevents:
     *  • `adb shell screencap` capturing the window
     *  • the task-switcher thumbnail from rendering the content
     *  • screen recording tools (incl. built-in Android 11+ recorder)
     *    from including the protected window
     *
     * Called from Flutter's `initState`/`dispose` on each sensitive page
     * (login, reset-password, change-password, MFA setup, payment input)
     * so non-sensitive screens remain screenshot-able.
     */
    private val secureChannel = "com.checkfood.checkfood_client/secure_screen"
    private val integrityChannel = "com.checkfood.checkfood_client/device_integrity"

    /**
     * Common absolute paths installed by root helpers (Magisk, Superuser,
     * SuperSU, busybox). If any of these is readable from the app sandbox,
     * the device is almost certainly rooted.
     */
    private val rootArtifacts = listOf(
        "/system/app/Superuser.apk",
        "/sbin/su",
        "/system/bin/su",
        "/system/xbin/su",
        "/data/local/xbin/su",
        "/data/local/bin/su",
        "/system/sd/xbin/su",
        "/system/bin/failsafe/su",
        "/data/local/su",
        "/su/bin/su",
        "/data/local/tmp/magisk",
        "/cache/magisk.log",
        "/data/adb/magisk"
    )

    override fun onCreate(savedInstanceState: Bundle?) {
        // Remove the Android 12 splash screen fade-out animation so the
        // transition to our Flutter splash is instant (no fade/dissolve).
        if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.S) {
            splashScreen.setOnExitAnimationListener { splashScreenView ->
                splashScreenView.remove()
            }
        }
        super.onCreate(savedInstanceState)
    }

    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)
        MethodChannel(flutterEngine.dartExecutor.binaryMessenger, secureChannel)
            .setMethodCallHandler { call, result ->
                when (call.method) {
                    "enable" -> {
                        runOnUiThread {
                            window.addFlags(WindowManager.LayoutParams.FLAG_SECURE)
                        }
                        result.success(null)
                    }
                    "disable" -> {
                        runOnUiThread {
                            window.clearFlags(WindowManager.LayoutParams.FLAG_SECURE)
                        }
                        result.success(null)
                    }
                    else -> result.notImplemented()
                }
            }

        MethodChannel(flutterEngine.dartExecutor.binaryMessenger, integrityChannel)
            .setMethodCallHandler { call, result ->
                when (call.method) {
                    "isCompromised" -> result.success(detectRoot())
                    else -> result.notImplemented()
                }
            }
    }

    /**
     * Light-weight root check. Returns true on any positive signal.
     * Warn-only policy on the Flutter side — this function must stay
     * cheap and false-positive-resistant, so we check two heuristics
     * that don't require shelling out to `which su`:
     *
     * 1. `Build.TAGS` containing "test-keys" — default AOSP/userdebug
     *    builds ship with test keys, which is a strong indicator of a
     *    custom ROM or emulator image running with root.
     * 2. Any of the known root-helper paths being readable via
     *    java.io.File#exists(). Magisk systemless mode can hide these
     *    from `ls`, but the Magisk daemon still leaves traces under
     *    `/data/adb/magisk`.
     */
    private fun detectRoot(): Boolean {
        val tags = Build.TAGS
        if (tags != null && tags.contains("test-keys")) {
            return true
        }
        return rootArtifacts.any {
            try {
                File(it).exists()
            } catch (_: SecurityException) {
                false
            }
        }
    }
}
