import co.touchlab.skie.configuration.FlowInterop

plugins {
    alias(libs.plugins.kotlinMultiplatform)
    alias(libs.plugins.androidLibrary)
    kotlin("native.cocoapods")
    kotlin("kapt")
    id("co.touchlab.skie") version "0.6.1"
}

version = "1.0.0"

kotlin {
    androidTarget()
    iosX64()
    iosArm64()
    iosSimulatorArm64()

    cocoapods {
        authors = "AlexeyG"
        license = "MIT"
        summary = "Library"
        homepage = "Link to a Kotlin/Native module homepage"
        name = "Shared"
        ios.deploymentTarget = "14.1"

        podfile = project.file("../iosApp/Podfile")

        framework {
            baseName = "Shared"
            isStatic = false
            export("org.orbit-mvi:orbit-core:6.1.0")
            export("dev.icerock.moko:mvvm-flow:0.16.1")
            export("dev.icerock.moko:mvvm-core:0.16.1")
        }
    }

    sourceSets {
        commonMain.dependencies {
            implementation("co.touchlab.skie:configuration-annotations:0.6.1")
            api("org.orbit-mvi:orbit-core:6.1.0")
            api("dev.icerock.moko:mvvm-flow:0.16.1")
            api("dev.icerock.moko:mvvm-core:0.16.1") // only ViewModel, EventsDispatcher, Dispatchers.UI
        }
    }
}

android {
    namespace = "org.example.project.shared"
    compileSdk = libs.versions.android.compileSdk.get().toInt()
    defaultConfig {
        minSdk = libs.versions.android.minSdk.get().toInt()
    }
}
