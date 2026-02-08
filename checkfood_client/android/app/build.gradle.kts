plugins {
    id("com.android.application")
    id("kotlin-android")
    // The Flutter Gradle Plugin must be applied after the Android and Kotlin Gradle plugins.
    id("dev.flutter.flutter-gradle-plugin")
}

android {
    namespace = "com.checkfood.checkfood_client"
    // OPRAVA 1: Ponecháno 36 (v pořádku pro nejnovější Android)
    compileSdk = 36
    ndkVersion = "27.0.12077973"

    compileOptions {
        // --- ZMĚNA ZDE: Upgrade na Java 17 (dnešní standard) ---
        sourceCompatibility = JavaVersion.VERSION_17
        targetCompatibility = JavaVersion.VERSION_17
    }

    kotlinOptions {
        // --- ZMĚNA ZDE: Upgrade JVM target na 17 ---
        jvmTarget = "17"
    }

    defaultConfig {
        // TODO: Specify your own unique Application ID (https://developer.android.com/studio/build/application-id.html).
        applicationId = "com.checkfood.checkfood_client"
        // You can update the following values to match your application needs.
        // For more information, see: https://flutter.dev/to/review-gradle-config.
        
        // OPRAVA 2: Ponecháno 24
        minSdk = 24
        
        // OPRAVA 3: Ponecháno 36
        targetSdk = 36
        
        versionCode = flutter.versionCode
        versionName = flutter.versionName
    }

    buildTypes {
        release {
            // TODO: Add your own signing config for the release build.
            // Signing with the debug keys for now, so `flutter run --release` works.
            signingConfig = signingConfigs.getByName("debug")
        }
    }
}

flutter {
    source = "../.."
}