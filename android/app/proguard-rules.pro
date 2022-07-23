-keep class  us.zoom.** { *; }
-keep class  com.zipow.** { *; }
-keep class  us.zipow.** { *; }
-keep class  org.webrtc.** { *; }
-keep class  us.google.protobuf.** { *; }
-keep class  org.apache.** { *; }
-keep class  org.igniterealtime.** { *; }
-keep class  com.amazonaws.** { *; }
-keep class  com.aldiferdiyan.** { *; }
-keep class  org.jivesoftware.** { *; }

-keep class com.google.android.gms.ads.identifier.** { *; }

-keep class com.google.android.gms.** { *; }

-keep class com.facebook.applinks.** { *; }
-keepclassmembers class com.facebook.applinks.** { *; }
-keep class com.facebook.FacebookSdk { *; }

-keep class com.huawei.hms.ads.** { *; }
-keep interface com.huawei.hms.ads.** { *; }

  -dontwarn us.zoom.**
  -dontwarn com.zipow.**