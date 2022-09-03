package com.whatsapp_auto.app

import android.content.ComponentName
import android.content.Intent
import android.os.Build
import android.provider.Settings
import android.text.TextUtils
import android.util.Log
import androidx.annotation.RequiresApi
import com.google.common.reflect.TypeToken
import com.google.gson.Gson
import com.google.gson.JsonObject
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugins.GeneratedPluginRegistrant
import java.lang.reflect.Type


class MainActivity : FlutterActivity() {

    private val CHANNEL = "samples.flutter.dev/battery"
    private val ACTION_NOTIFICATION_LISTENER_SETTINGS =
        "android.settings.ACTION_NOTIFICATION_LISTENER_SETTINGS"
    private val ENABLED_NOTIFICATION_LISTENERS = "enabled_notification_listeners"

    @RequiresApi(Build.VERSION_CODES.O)
    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        GeneratedPluginRegistrant.registerWith(flutterEngine)

        super.configureFlutterEngine(flutterEngine)

//        try {
//
//            String newVersion = Jsoup.connect("https://play.google.com/store/apps/details?id=com.imangi.templerun2" + "&hl=en")
//                .timeout(30000)
//                .userAgent("Mozilla/5.0 (Windows; U; WindowsNT 5.1; en-US; rv1.8.1.6) Gecko/20070725 Firefox/2.0.0.6")
//                .referrer("http://www.google.com")
//                .get()
//                .select("div[itemprop=softwareVersion]")
//                .first()
//                .ownText();
//            Log.d("storeVersion", newVersion);
//        } catch (IOException e) {
//            Log.d("storeVersion exception", e.getLocalizeMessage());
//            e.printStackTrace();
//        }

        ///
//        val versionChecker = VersionChecker()
//        val latestVersion: String = versionChecker.execute().get()
//
//
//        val versionChecker: VersionChecker = VersionChecker()
//        try {
//            val latestVersion: Document = versionChecker.execute().get()
//            Log.d("TAG~~~", "onCreate: $latestVersion")
//        } catch (e: ExecutionException) {
//            e.printStackTrace()
//            Log.d("TAG~~~", "onCreate: Exception :  " + e.localizedMessage)
//        } catch (e: InterruptedException) {
//            Log.d("TAG~~~", "onCreate: InterruptedException :  " + e.localizedMessage)
//            e.printStackTrace()
//        }

//        try {
//            val newVersion: String =
//                Jsoup.connect("https://play.google.com/store/apps/details?id=com.imangi.templerun2" + "&hl=en")
//                    .timeout(30000)
//                    .userAgent("Mozilla/5.0 (Windows; U; WindowsNT 5.1; en-US; rv1.8.1.6) Gecko/20070725 Firefox/2.0.0.6")
//                    .referrer("http://www.google.com")
//                    .get()
//                    .select("div[itemprop=softwareVersion]")
//                    .first()
//                    .ownText()
//            Log.d("tag", "storeVersion:  $newVersion")
//        } catch (e) {
//            e
//            Log.d("tag", "storeVersion exception:  ${e}")
//        }

        MethodChannel(
            flutterEngine.dartExecutor.binaryMessenger,
            CHANNEL
        ).setMethodCallHandler { call, result ->

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
                Log.d("tag", "notificationDisable --->>> 1")
                val editor = getSharedPreferences("MY_PREFS_NAME", MODE_PRIVATE).edit()
                Log.d("tag", "notificationDisable --->>> 2")

                editor.putBoolean("isChecked", false)
                Log.d("tag", "notificationDisable --->>> 3")

                val intent = Intent(this@MainActivity, WhatsReNotificationListner::class.java)
                Log.d("tag", "notificationDisable --->>> 4")

                intent.action = "STOP_FOREGROUND_REMOVE"
                Log.d("tag", "notificationDisable --->>> 5")

                startForegroundService(intent)
                Log.d("tag", "notificationDisable --->>> 6")
                editor.apply()
                Log.d("tag", "notificationDisable --->>> 7")


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
                Log.d("tag", "language === >>>>123 ")

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
                Log.d("tag", "instagramResponse === >>>> " + language)
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

            if (call.method == "setTelegram") {
                var text: Boolean? = call.argument<Boolean>("telegram");
                val editor = getSharedPreferences("MY_PREFS_NAME", MODE_PRIVATE).edit()
                if (text == true) {
                    editor.putBoolean("org.telegram.messenger", true);
                } else {
                    editor.putBoolean("org.telegram.messenger", false);
                }
                editor.apply()
                val get = getSharedPreferences("MY_PREFS_NAME", MODE_PRIVATE)
                var language = get.getBoolean("org.telegram.messenger", false)
                Log.d("tag", "telegram === >>>> " + language)
            }

            if (call.method == "addNewMessage") {
                val message = call.argument<String>("message");
                Log.d("tag", "newCreatedMessage 0000=== >>>> " + message)

                val replyMessage = call.argument<String>("replyMessage");
                Log.d("tag", "newCreatedMessage 111=== >>>> " + replyMessage)

                val editor = getSharedPreferences("MY_PREFS_NAME", MODE_PRIVATE).edit()
                editor.putString("botMessage-" + message, replyMessage)
                editor.apply()
                val get = getSharedPreferences("MY_PREFS_NAME", MODE_PRIVATE)
                var botMessage = get.getString("botMessage-" + message, "")
                Log.d("tag", "newCreatedMessage === >>>> " + botMessage)
            }

            if (call.method == "getMessageCount") {

                val get = getSharedPreferences("MY_PREFS_NAME", MODE_PRIVATE)
                var messageCount = get.getInt("messageCount", 0)
                result.success(messageCount.toString())

            }
            if (call.method == "getFbMessageCount") {
                Log.d("TAG", "getFbMessageCount~~ ");

                val get = getSharedPreferences("MY_PREFS_NAME", MODE_PRIVATE)
                var fbMessageCount = get.getInt("facebookMessageCount", 0)
                Log.d(
                    "TAG", "getFbMessageCount~~ 1 :"
                            + fbMessageCount
                );

                result.success(fbMessageCount.toString())
                Log.d("TAG", "result.success--- :");

            }
            if (call.method == "getTelegramMessageCount") {
                Log.d("TAG", "getTelegramMessageCount~~ ");

                val get = getSharedPreferences("MY_PREFS_NAME", MODE_PRIVATE)
                var telegramMessageCount = get.getInt("telegramMessageCount", 0)
                Log.d(
                    "TAG", "telegramMessageCount~~ 1 :"
                            + telegramMessageCount
                );

                result.success(telegramMessageCount.toString())
                Log.d("TAG", "result.success--- :");

            }
            if (call.method == "getTwitterMessageCount") {
                Log.d("TAG", "getTwitterMessageCount~~ ");

                val get = getSharedPreferences("MY_PREFS_NAME", MODE_PRIVATE)
                var twitterMessageCount = get.getInt("twitterMessageCount", 0)
                Log.d(
                    "TAG", "twitterMessageCount~~ 1 :"
                            + twitterMessageCount
                );

                result.success(twitterMessageCount.toString())
                Log.d("TAG", "result.success--- :");

            }
            if (call.method == "getWhatsappBusiMessageCount") {
                Log.d("TAG", "getWhatsappBusiMessageCount~~ ");

                val get = getSharedPreferences("MY_PREFS_NAME", MODE_PRIVATE)
                var whatsAppBusinessMessageCount = get.getInt("whatsAppBusinessMessageCount", 0)
                Log.d(
                    "TAG", "whatsAppBusinessMessageCount~~ 1 :"
                            + whatsAppBusinessMessageCount
                );

                result.success(whatsAppBusinessMessageCount.toString())
                Log.d("TAG", "result.success--- :");

            }
            if (call.method == "getInstaMessageCount") {
                Log.d("TAG", "getInstaMessageCount~~ ");

                val get = getSharedPreferences("MY_PREFS_NAME", MODE_PRIVATE)
                var instaMessageCount = get.getInt("instaMessageCount", 0)
                Log.d(
                    "TAG", "instaMessageCount~~ 1 :"
                            + instaMessageCount
                );

                result.success(instaMessageCount.toString())
                Log.d("TAG", "result.success--- :");

            }
            if (call.method == "autoReplyTo") {
                val autoReplyTo = call.argument<String>("autoReplyTo");
                Log.d("tag", "AUTO REPLY TO contactList === >>>> " + autoReplyTo)

                val editor = getSharedPreferences("MY_PREFS_NAME", MODE_PRIVATE).edit()
                editor.putString("autoReplyTo", autoReplyTo)
                editor.apply()
                val get = getSharedPreferences("MY_PREFS_NAME", MODE_PRIVATE)
                var botMessage = get.getString("autoReplyTo", "")
                Log.d("tag", "AUTO REPLY TO autoReplyTo === >>>> " + autoReplyTo)
            }

            if (call.method == "allContacts") {
                val contactList = call.argument<String>("contactList");
                Log.d("tag", "ALL CONTACTS contactList === >>>> " + contactList)

                val editor = getSharedPreferences("MY_PREFS_NAME", MODE_PRIVATE).edit()
                editor.putString("contactList", contactList)
                editor.apply()
                val get = getSharedPreferences("MY_PREFS_NAME", MODE_PRIVATE)
                var allContactList = get.getString("contactList", "")
                Log.d("tag", "ALL CONTACTS contactList === >>>> " + allContactList)
            }

            if (call.method == "selectedContact") {



                val selectedContact = call.argument<String>("selectedContact");
                Log.d("tag", "selectedContact selectedContact === >>>> " + selectedContact)

                val editor = getSharedPreferences("MY_PREFS_NAME", MODE_PRIVATE).edit()
                editor.putString("selectedContact", selectedContact)
                editor.apply()
                val get = getSharedPreferences("MY_PREFS_NAME", MODE_PRIVATE)
                val allSelectedContact = get.getString("selectedContact", "")
                Log.d("tag", "selectedContact allSelectedContact === >>>> " + allSelectedContact)

//                val gson = Gson();
//                val arrayOfDogs: Array<ContactModel> = gson.fromJson(
//                    allSelectedContact,
//                    Array<ContactModel>::class.java
//                )
//
//                Log.d("tag", "selectedContact arrayList === >>>> " + arrayOfDogs.size)

            }
        }

    }

    private fun isNotificationServiceEnabled(): Boolean {
        val pkgName = packageName
        val flat = Settings.Secure.getString(
            contentResolver,
            ENABLED_NOTIFICATION_LISTENERS
        )
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

//    class VersionChecke : AsyncTask<String, String, String>() {
//         fun doInBackground(vararg params: String?): String {
//            TODO("Not yet implemented")
//
//            val newVersion: String
//
//            try {
//                newVersion =
//                    Jsoup.connect("https://play.google.com/store/apps/details?id=com.whatsapp.w4b" + "&hl=en")
//                        .timeout(20000)
//                        .userAgent("Mozilla/5.0 (Windows; U; WindowsNT 5.1; en-US; rv1.8.1.6) Gecko/20070725 Firefox/2.0.0.6")
//                        .referrer("http://www.google.com")
//                        .get()
//                        .select("div.hAyfc:nth-child(4) > span:nth-child(2) > div:nth-child(1) > span:nth-child(1)")
//                        .first()
//                        .ownText()
//                Log.d("tag", "storeVersion:  $newVersion")
//            } catch (e: IOException) {
//                e.printStackTrace()
//                Log.d("tag", "storeVersion exception:  ${e.localizedMessage}")
//            }
//            return newVersion
//        }
//
//    }

}