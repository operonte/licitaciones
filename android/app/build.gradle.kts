plugins {
    id("com.android.application")
    // The Flutter Gradle Plugin must be applied after the Android and Kotlin Gradle plugins.
    id("dev.flutter.flutter-gradle-plugin")
}


// Load signing properties from android/key.properties at repo root (optional)
val keystorePropertiesFile = rootProject.file("key.properties")
val keystoreProperties: Map<String, String> = if (keystorePropertiesFile.exists()) {
    keystorePropertiesFile.readLines()
        .mapNotNull { line ->
            val trimmed = line.trim()
            if (trimmed.isEmpty() || trimmed.startsWith("#")) return@mapNotNull null
            val parts = trimmed.split("=", limit = 2)
            if (parts.size == 2) parts[0].trim() to parts[1].trim() else null
        }
        .toMap()
} else {
    emptyMap()
}

android {
    namespace = "com.security.licitaciones.licitaciones"
    // Set a modern compileSdk to satisfy Android library dependencies
    compileSdk = 36
    ndkVersion = flutter.ndkVersion

    compileOptions {
        sourceCompatibility = JavaVersion.VERSION_17
        targetCompatibility = JavaVersion.VERSION_17
        isCoreLibraryDesugaringEnabled = true
    }

    defaultConfig {
        // TODO: Specify your own unique Application ID (https://developer.android.com/studio/build/application-id.html).
        applicationId = "com.security.licitaciones.licitaciones"
        // You can update the following values to match your application needs.
        // For more information, see: https://flutter.dev/to/review-gradle-config.
        minSdk = flutter.minSdkVersion
        targetSdk = flutter.targetSdkVersion
        versionCode = flutter.versionCode
        versionName = flutter.versionName
    }

    buildTypes {
        release {
            // Use a release signing config when `key.properties` is present.
            // Otherwise fall back to debug signing so local release runs still work.
            if (keystorePropertiesFile.exists()) {
                // create or configure the release signing config
                signingConfigs.create("release") {
                    keyAlias = keystoreProperties["keyAlias"]
                    keyPassword = keystoreProperties["keyPassword"]
                    val storePath = keystoreProperties["storeFile"]
                    if (!storePath.isNullOrBlank()) {
                        storeFile = file(storePath)
                    }
                    storePassword = keystoreProperties["storePassword"]
                }
                signingConfig = signingConfigs.getByName("release")
            } else {
                // no release keystore provided: use debug for convenience
                signingConfig = signingConfigs.getByName("debug")
            }
        }
    }
}

kotlin {
    compilerOptions {
        jvmTarget = org.jetbrains.kotlin.gradle.dsl.JvmTarget.JVM_17
    }
}

flutter {
    source = "../.."
}

dependencies {
    coreLibraryDesugaring("com.android.tools:desugar_jdk_libs:2.0.4")
}
