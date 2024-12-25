# Please add these rules to your existing keep rules in order to suppress warnings.
# This is generated automatically by the Android Gradle plugin.
-dontwarn com.google.errorprone.annotations.CanIgnoreReturnValue
-dontwarn com.google.errorprone.annotations.CheckReturnValue
-dontwarn com.google.errorprone.annotations.Immutable
-dontwarn com.google.errorprone.annotations.RestrictedApi
-dontwarn javax.annotation.Nullable
-dontwarn javax.annotation.concurrent.GuardedBy

# Keep Tink crypto library classes
-keep class com.google.crypto.tink.** { *; }
-keepclassmembers class * {
    @com.google.crypto.tink.annotations.* *;
}

# Keep Error Prone annotations
-dontwarn com.google.errorprone.annotations.**
-keep class com.google.errorprone.annotations.** { *; }

# Keep JSR305 annotations
-dontwarn javax.annotation.**
-keep class javax.annotation.** { *; }

# Google API Client
-keep class com.google.api.client.** { *; }
-keep class com.google.http-client.** { *; }

# Joda Time
-keep class org.joda.time.** { *; }
-dontwarn org.joda.time.**

# Google HTTP Client
-keepclassmembers class * {
  @com.google.api.client.http.** *;
}
-dontwarn com.google.api.client.http.**
-dontwarn com.google.api.client.util.**

# Google Play Services
-keep class com.google.android.gms.** { *; }
-dontwarn com.google.android.gms.**
-keep class com.google.api.client.googleapis.** { *; }
-keep class com.google.api.services.** { *; }