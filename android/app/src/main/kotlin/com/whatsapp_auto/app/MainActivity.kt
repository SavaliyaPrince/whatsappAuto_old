package com.whatsapp_auto.app

//import android.app.AlertDialog
//import android.app.Notification
//import android.app.NotificationChannel
//import android.app.NotificationManager
//import android.content.ComponentName
//import android.content.DialogInterface
//import android.content.Intent
//import android.os.Build
//import android.provider.Settings
//import android.text.TextUtils
//import android.util.Log
//import android.view.View
//import android.widget.CompoundButton
//import androidx.annotation.RequiresApi
//import com.whatsapp_auto.app.WhatsReNotificationListner
//import io.flutter.embedding.android.FlutterActivity
//import io.flutter.embedding.engine.FlutterEngine
//import io.flutter.plugin.common.MethodChannel
//import io.flutter.plugins.GeneratedPluginRegistrant
//
//class MainActivity : FlutterActivity() {
//
//    private val CHANNEL = "samples.flutter.dev/battery"
//    private val ACTION_NOTIFICATION_LISTENER_SETTINGS = "android.settings.ACTION_NOTIFICATION_LISTENER_SETTINGS"
//    private val ENABLED_NOTIFICATION_LISTENERS = "enabled_notification_listeners"
//
//    @RequiresApi(Build.VERSION_CODES.O)
//    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
//        GeneratedPluginRegistrant.registerWith(flutterEngine)
//
//        super.configureFlutterEngine(flutterEngine)
//        MethodChannel(flutterEngine.dartExecutor.binaryMessenger, CHANNEL).setMethodCallHandler { call, result ->
//
//            if (call.method == "checkNotificationServiceEnabled") {
//                var res = isNotificationServiceEnabled();
//                result.success(res)
//            }
//
//            if (call.method == "serviceEnable") {
//                startActivity(Intent(ACTION_NOTIFICATION_LISTENER_SETTINGS))
//                val intent = Intent(this, WhatsReNotificationListner::class.java)
//                intent.action = "START_FOREGROUND_REMOVE"
//                startForegroundService(intent)
//            }
//
//
//
//            if (call.method == "notificationEnable") {
//                Log.d("tag", "language === >>>>000 ")
//
//                //on
//                val intent = Intent(this, WhatsReNotificationListner::class.java)
//                Log.d("tag", "language === >>>>111 ")
//
//                intent.action = "START_FOREGROUND_REMOVE"
//                Log.d("tag", "language === >>>>222")
//
//                startForegroundService(intent)
//                Log.d("tag", "language === >>>>333")
//
//                val editor = getSharedPreferences("MY_PREFS_NAME", MODE_PRIVATE).edit()
//                Log.d("tag", "language === >>>>444")
//
//                editor.putBoolean("isChecked", true)
//                Log.d("tag", "language === >>>>555")
//                editor.apply()
//                Log.d("tag", "language === >>>>666")
//
//            }
//
//            if (call.method == "notificationDisable") {
//                // off
//                val editor = getSharedPreferences("MY_PREFS_NAME", MODE_PRIVATE).edit()
//                editor.putBoolean("isChecked", false)
//
//                val intent = Intent(this@MainActivity, WhatsReNotificationListner::class.java)
//                intent.action = "STOP_FOREGROUND_REMOVE"
//                startForegroundService(intent)
//                editor.apply()
//
//            }
//
//            if (call.method == "setSellerId") {
//                val text = call.argument<String>("sellerID");
//
//
//                val editor = getSharedPreferences("MY_PREFS_NAME", MODE_PRIVATE).edit()
//                editor.putString("sellerchannel", text)
//                editor.apply()
//
//            }
//
//            if (call.method == "setLanguage") {
//                val text = call.argument<String>("languageCode");
//                val editor = getSharedPreferences("MY_PREFS_NAME", MODE_PRIVATE).edit()
//                editor.putString("getLanguage", text)
//                editor.apply()
//                val get = getSharedPreferences("MY_PREFS_NAME", MODE_PRIVATE)
//                var language = get.getString("getLanguage", "")
//                Log.d("tag", "language === >>>> " + language)
//            }
//
////            if (call.method == "setSocialChat") {
////                val text = call.argument<String>("languageCode");
//            if (call.method == "setWhatsApp") {
//                var text: Boolean? = call.argument<Boolean>("whatsapp");
//                Log.d("Enter", "Working  " + text.toString())
//
//                val editor = getSharedPreferences("MY_PREFS_NAME", MODE_PRIVATE).edit()
//                if (text == true) {
//                    editor.putBoolean("com.whatsapp", true);
//
//
//                    Log.d("tag", "language === >>>>000 ")
//
//                    //on
//                    val intent = Intent(this, WhatsReNotificationListner::class.java)
//                    Log.d("tag", "language === >>>>111 ")
//
//                    intent.action = "START_FOREGROUND_REMOVE"
//                    Log.d("tag", "language === >>>>222")
//
//                    startForegroundService(intent)
//                    Log.d("tag", "language === >>>>333")
//
//                    val editors = getSharedPreferences("MY_PREFS_NAME", MODE_PRIVATE).edit()
//                    Log.d("tag", "language === >>>>444")
//
//                    editors.putBoolean("isChecked", true)
//                    Log.d("tag", "language === >>>>555")
//                    editors.apply()
//                    Log.d("tag", "language === >>>>666")
//
//
//                } else {
//                    editor.putBoolean("com.whatsapp", false);
//                }
//                editor.apply()
//                val get = getSharedPreferences("MY_PREFS_NAME", MODE_PRIVATE)
//                var language = get.getBoolean("com.whatsapp", false)
//                Log.d("tag", "whatsapp === >>>> " + language)
//            }
//
//            if (call.method == "setWhatsappBusiness") {
//                var text: Boolean? = call.argument<Boolean>("whatsappBusiness");
//                val editor = getSharedPreferences("MY_PREFS_NAME", MODE_PRIVATE).edit()
//                if (text == true) {
//                    editor.putBoolean("com.whatsapp.w4b", true);
//                } else {
//                    editor.putBoolean("com.whatsapp.w4b", false);
//                }
//                editor.apply()
//                val get = getSharedPreferences("MY_PREFS_NAME", MODE_PRIVATE)
//                var language = get.getBoolean("com.whatsapp.w4b", false)
//                Log.d("tag", "getWhatsappBusiness === >>>> " + language)
//            }
//
//            if (call.method == "setInstagramResponse") {
//                var text: Boolean? = call.argument<Boolean>("instagramResponse");
//                val editor = getSharedPreferences("MY_PREFS_NAME", MODE_PRIVATE).edit()
//                if (text == true) {
//                    editor.putBoolean("com.instagram.android", true);
//                } else {
//                    editor.putBoolean("com.instagram.android", false);
//                }
//                editor.apply()
//                val get = getSharedPreferences("MY_PREFS_NAME", MODE_PRIVATE)
//                var language = get.getBoolean("com.instagram.android", false)
//                Log.d("tag", "getInstagramResponse === >>>> " + language)
//            }
//
//            if (call.method == "setFacebook") {
//                var text: Boolean? = call.argument<Boolean>("facebook");
//                val editor = getSharedPreferences("MY_PREFS_NAME", MODE_PRIVATE).edit()
//                if (text == true) {
//                    editor.putBoolean("com.facebook.orca", true);
//                } else {
//                    editor.putBoolean("com.facebook.orca", false);
//                }
//                editor.apply()
//                val get = getSharedPreferences("MY_PREFS_NAME", MODE_PRIVATE)
//                var language = get.getBoolean("com.facebook.orca", false)
//                Log.d("tag", "facebook === >>>> " + language)
//            }
//
//            if (call.method == "setTwitter") {
//                var text: Boolean? = call.argument<Boolean>("twitter");
//                val editor = getSharedPreferences("MY_PREFS_NAME", MODE_PRIVATE).edit()
//                if (text == true) {
//                    editor.putBoolean("com.twitter.android", true);
//                } else {
//                    editor.putBoolean("com.twitter.android", false);
//                }
//                editor.apply()
//                val get = getSharedPreferences("MY_PREFS_NAME", MODE_PRIVATE)
//                var language = get.getBoolean("com.twitter.android", false)
//                Log.d("tag", "twitter === >>>> " + language)
//            }
////            }
//
//            if (call.method == "uploadVideo") {
//                val filePath = call.argument<String>("filePath");
//                ///TODO: uploadVideo FilePath
//                Log.d("tag", "uploadVideo  filePath === >>>> " + filePath)
//                result.success(filePath)
//            }
//
//        }
//
//    }
//
//    private fun isNotificationServiceEnabled(): Boolean {
//        val pkgName = packageName
//        val flat = Settings.Secure.getString(contentResolver,
//                ENABLED_NOTIFICATION_LISTENERS)
//        if (!TextUtils.isEmpty(flat)) {
//            val names = flat.split(":".toRegex()).toTypedArray()
//            for (i in names.indices) {
//                val cn = ComponentName.unflattenFromString(names[i])
//                if (cn != null) {
//                    if (TextUtils.equals(pkgName, cn.packageName)) {
//                        return true
//                    }
//                }
//            }
//        }
//        return false
//    }
//}

import android.app.AlertDialog
import android.app.Notification
import android.app.NotificationChannel
import android.app.NotificationManager
import android.content.ComponentName
import android.content.DialogInterface
import android.content.Intent
import android.os.Build
import android.provider.Settings
import android.text.TextUtils
import android.util.Log
import android.view.View
import android.widget.CompoundButton
import androidx.annotation.RequiresApi
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugins.GeneratedPluginRegistrant

class MainActivity : FlutterActivity() {

    private val CHANNEL = "samples.flutter.dev/battery"
    private val ACTION_NOTIFICATION_LISTENER_SETTINGS = "android.settings.ACTION_NOTIFICATION_LISTENER_SETTINGS"
    private val ENABLED_NOTIFICATION_LISTENERS = "enabled_notification_listeners"

    @RequiresApi(Build.VERSION_CODES.O)
    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        GeneratedPluginRegistrant.registerWith(flutterEngine)

        super.configureFlutterEngine(flutterEngine)
        MethodChannel(flutterEngine.dartExecutor.binaryMessenger, CHANNEL).setMethodCallHandler { call, result ->

            if (call.method == "checkNotificationServiceEnabled") {
                var res = isNotificationServiceEnabled();
                result.success(res)

            }

            if (call.method == "serviceEnable") {
                startActivity(Intent(ACTION_NOTIFICATION_LISTENER_SETTINGS))
                val intent = Intent(this, WhatsReNotificationListner::class.java)
                intent.action = "START_FOREGROUND_REMOVE"
                startForegroundService(intent)
            }



            if (call.method == "notificationEnable") {
                Log.d("tag", "language === >>>>000 ")

                //on
                val intent = Intent(this, WhatsReNotificationListner::class.java)
                Log.d("tag", "language === >>>>111 ")

                intent.action = "START_FOREGROUND_REMOVE"
                Log.d("tag", "language === >>>>222")

                startForegroundService(intent)
                Log.d("tag", "language === >>>>333")

                val editor = getSharedPreferences("MY_PREFS_NAME", MODE_PRIVATE).edit()
                Log.d("tag", "language === >>>>444")

                editor.putBoolean("isChecked", true)
                Log.d("tag", "language === >>>>555")
                editor.apply()
                Log.d("tag", "language === >>>>666")

            }

            if (call.method == "notificationDisable") {
                // off
                val editor = getSharedPreferences("MY_PREFS_NAME", MODE_PRIVATE).edit()
                editor.putBoolean("isChecked", false)

                val intent = Intent(this@MainActivity, WhatsReNotificationListner::class.java)
                intent.action = "STOP_FOREGROUND_REMOVE"
                startForegroundService(intent)
                editor.apply()

            }

            if (call.method == "setSellerId") {
                val text = call.argument<String>("sellerID");


                val editor = getSharedPreferences("MY_PREFS_NAME", MODE_PRIVATE).edit()
                editor.putString("sellerchannel", text)
                editor.apply()

            }

            if (call.method == "setLanguage") {
                val text = call.argument<String>("languageCode");
                val editor = getSharedPreferences("MY_PREFS_NAME", MODE_PRIVATE).edit()
                editor.putString("getLanguage", text)
                editor.apply()
                val get = getSharedPreferences("MY_PREFS_NAME", MODE_PRIVATE)
                var language = get.getString("getLanguage", "")
                Log.d("tag", "language === >>>> " + language)
            }

//            if (call.method == "setSocialChat") {
//                val text = call.argument<String>("languageCode");
            if (call.method == "setWhatsApp") {
                var text: Boolean? = call.argument<Boolean>("whatsapp");
                Log.d("Enter", "Working  " + text.toString())

                val editor = getSharedPreferences("MY_PREFS_NAME", MODE_PRIVATE).edit()
                if (text == true) {
                    editor.putBoolean("com.whatsapp", true);


                    Log.d("tag", "language === >>>>000 ")

                    //on
                    val intent = Intent(this, WhatsReNotificationListner::class.java)
                    Log.d("tag", "language === >>>>111 ")

                    intent.action = "START_FOREGROUND_REMOVE"
                    Log.d("tag", "language === >>>>222")

                    startForegroundService(intent)
                    Log.d("tag", "language === >>>>333")

                    val editors = getSharedPreferences("MY_PREFS_NAME", MODE_PRIVATE).edit()
                    Log.d("tag", "language === >>>>444")

                    editors.putBoolean("isChecked", true)
                    Log.d("tag", "language === >>>>555")
                    editors.apply()
                    Log.d("tag", "language === >>>>666")


                } else {
                    editor.putBoolean("com.whatsapp", false);
                }
                editor.apply()
                val get = getSharedPreferences("MY_PREFS_NAME", MODE_PRIVATE)
                var language = get.getBoolean("com.whatsapp", false)
                Log.d("tag", "whatsapp === >>>> " + language)
            }

            if (call.method == "setWhatsappBusiness") {
                var text: Boolean? = call.argument<Boolean>("whatsappBusiness");
                val editor = getSharedPreferences("MY_PREFS_NAME", MODE_PRIVATE).edit()
                if (text == true) {
                    editor.putBoolean("com.whatsapp.w4b", true);
                } else {
                    editor.putBoolean("com.whatsapp.w4b", false);
                }
                editor.apply()
                val get = getSharedPreferences("MY_PREFS_NAME", MODE_PRIVATE)
                var language = get.getBoolean("com.whatsapp.w4b", false)
                Log.d("tag", "getWhatsappBusiness === >>>> " + language)
            }

            if (call.method == "setInstagramResponse") {
                var text: Boolean? = call.argument<Boolean>("instagramResponse");
                val editor = getSharedPreferences("MY_PREFS_NAME", MODE_PRIVATE).edit()
                if (text == true) {
                    editor.putBoolean("com.instagram.android", true);
                } else {
                    editor.putBoolean("com.instagram.android", false);
                }
                editor.apply()
                val get = getSharedPreferences("MY_PREFS_NAME", MODE_PRIVATE)
                var language = get.getBoolean("com.instagram.android", false)
                Log.d("tag", "getInstagramResponse === >>>> " + language)
            }

            if (call.method == "setFacebook") {
                var text: Boolean? = call.argument<Boolean>("facebook");
                val editor = getSharedPreferences("MY_PREFS_NAME", MODE_PRIVATE).edit()
                if (text == true) {
                    editor.putBoolean("com.facebook.orca", true);
                } else {
                    editor.putBoolean("com.facebook.orca", false);
                }
                editor.apply()
                val get = getSharedPreferences("MY_PREFS_NAME", MODE_PRIVATE)
                var language = get.getBoolean("com.facebook.orca", false)
                Log.d("tag", "facebook === >>>> " + language)
            }

            if (call.method == "setTwitter") {
                var text: Boolean? = call.argument<Boolean>("twitter");
                val editor = getSharedPreferences("MY_PREFS_NAME", MODE_PRIVATE).edit()
                if (text == true) {
                    editor.putBoolean("com.twitter.android", true);
                } else {
                    editor.putBoolean("com.twitter.android", false);
                }
                editor.apply()
                val get = getSharedPreferences("MY_PREFS_NAME", MODE_PRIVATE)
                var language = get.getBoolean("com.twitter.android", false)
                Log.d("tag", "twitter === >>>> " + language)
            }

            if (call.method == "addNewMessage") {
                val message = call.argument<String>("message");
                val replyMessage = call.argument<String>("replyMessage");
                val editor = getSharedPreferences("MY_PREFS_NAME", MODE_PRIVATE).edit()
                editor.putString("botMessage-" + message, replyMessage)
                editor.apply()
                val get = getSharedPreferences("MY_PREFS_NAME", MODE_PRIVATE)
                var botMessage = get.getString("botMessage-" + message, "")
                Log.d("tag", "newCreatedMessage === >>>> " + botMessage)
            }

//            }


        }

    }

    private fun isNotificationServiceEnabled(): Boolean {
        val pkgName = packageName
        val flat = Settings.Secure.getString(contentResolver,
            ENABLED_NOTIFICATION_LISTENERS)
        if (!TextUtils.isEmpty(flat)) {
            val names = flat.split(":".toRegex()).toTypedArray()
            for (i in names.indices) {
                val cn = ComponentName.unflattenFromString(names[i])
                if (cn != null) {
                    if (TextUtils.equals(pkgName, cn.packageName)) {
                        return true
                    }
                }
            }
        }
        return false
    }

}