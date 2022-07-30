package com.whatsapp_auto.app;

import android.annotation.SuppressLint;
import android.app.Notification;
import android.app.NotificationChannel;
import android.app.NotificationManager;
import android.app.PendingIntent;
import android.app.Person;
import android.app.RemoteInput;
import android.content.ContentResolver;
import android.content.Context;
import android.content.Intent;
import android.content.SharedPreferences;
import android.database.Cursor;
import android.net.Uri;
import android.os.Build;
import android.os.Bundle;
import android.os.Environment;
import android.os.IBinder;
import android.os.Parcelable;
import android.provider.ContactsContract;
import android.service.notification.NotificationListenerService;
import android.service.notification.StatusBarNotification;
import android.telephony.TelephonyManager;
import android.util.ArrayMap;
import android.util.Log;

import androidx.annotation.RequiresApi;
import androidx.core.app.NotificationCompat;

import org.json.JSONObject;

import java.io.BufferedWriter;
import java.io.File;
import java.io.FileWriter;
import java.io.IOException;
import java.net.SocketTimeoutException;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import com.whatsapp_auto.app.BuildConfig;
import com.whatsapp_auto.app.R;

import io.reactivex.Observable;
import io.reactivex.android.schedulers.AndroidSchedulers;
import io.reactivex.observers.DisposableObserver;
import io.reactivex.schedulers.Schedulers;
import okhttp3.RequestBody;
import okhttp3.ResponseBody;
import retrofit2.Call;
import retrofit2.Callback;
import retrofit2.Response;
import retrofit2.Retrofit;
import retrofit2.converter.gson.GsonConverterFactory;


public class
WhatsReNotificationListner extends NotificationListenerService {


    // Constants
    private static final int ID_SERVICE = 101;
    String packageName;
    String[] senders;

    public List<Long> waLastRawId = new ArrayList<>();

    @Override
    public int onStartCommand(Intent intent, int flags, int startId) {
        super.onStartCommand(intent, flags, startId);

        Log.d("TAG", "id~~>001");
        if (intent != null && intent.getAction() != null && intent.getAction().equals("STOP_FOREGROUND_REMOVE")) {
            stopForeground(true);
            stopSelf();
            Log.d("TAG", "id~~>002");
        } else if (intent != null && intent.getAction() != null && intent.getAction().equals("START_FOREGROUND_REMOVE")) {
//            NotificationManager notificationManager = (NotificationManager) getSystemService(Context.NOTIFICATION_SERVICE);
//            String channelId = createNotificationChannel(notificationManager);
//            NotificationCompat.Builder notificationBuilder = new NotificationCompat.Builder(this, channelId);
//            Notification notification = notificationBuilder.setOngoing(true)
//                    .setSmallIcon(R.mipmap.ic_launcher)
//                    .setPriority(PRIORITY_MIN)
//                    .setCategory(NotificationCompat.CATEGORY_SERVICE)
//                    .build();
//
//            startForeground(ID_SERVICE, notification);

            Notification.Builder builder = null;
            final NotificationChannel channel;
            if (android.os.Build.VERSION.SDK_INT >= android.os.Build.VERSION_CODES.O) {
                channel = new NotificationChannel("1",
                        "iMoe_Service", NotificationManager.IMPORTANCE_LOW);
                channel.setDescription("WhatsappTools WhatsAuto");
                channel.setSound(null, null);
                channel.enableLights(false);
                channel.setLockscreenVisibility(Notification.VISIBILITY_PUBLIC);
                channel.setShowBadge(false);
                final NotificationManager manager = (NotificationManager) getSystemService(Context.NOTIFICATION_SERVICE);
                manager.createNotificationChannel(channel);
                builder = new Notification.Builder(this, channel.getId());
                final Notification notify = builder
                        .setContentTitle("Auto Reply")
                        // .setContentText("2123")
                        .setWhen(System.currentTimeMillis())
                        .setSmallIcon(R.mipmap.launcher_icon)
                        .setOngoing(true).setAutoCancel(false)
                        // .setLargeIcon(BitmapFactory.decodeResource(getResources(),android.R.drawable.ic_dialog_info))
                        .build();
                startForeground(1, notify);
                Log.d("TAG", "id~~>003");
            } else {
                NotificationCompat.Builder b = new NotificationCompat.Builder(this);
                b.setAutoCancel(true)
                        .setDefaults(Notification.DEFAULT_ALL)
                        .setWhen(System.currentTimeMillis())
                        .setSmallIcon(R.mipmap.launcher_icon)
                        .setContentTitle("Auto Reply")
                        .setOngoing(true)
                        .setAutoCancel(false);
                startForeground(1, b.build());
            }

        }
        return START_STICKY;
    }

    private static final class ApplicationPackageNames {
        public static final String WHATSAPP_PACKNAME = "com.whatsapp";
        public static final String WHATSAPP_PACKNAME_BUSINESS = "com.whatsapp.w4b";
        public static final String INSTA_PACKNAME = "com.instagram.android";
        public static final String TWITTER_PACKNAME = "com.twitter.android";
        public static final String FACEBOOK_PACKNAME = "com.facebook.orca";
        public static final String TELEGRAM_PACKNAME = "org.telegram.messenger";
    }

    public static final class InterceptedNotificationCode {
        public static final int WHATSAPP_CODE = 2;
        public static final int OTHER_NOTIFICATIONS_CODE = 4; // We ignore all notification with code == 4
    }

    public static final class InterceptedNotificationParseCode {
        public static final String ANDROID_TITLE = "android.title";
        public static final String ANDROID_TEXT = "android.text"; // We ignore all notification with code == 4
        public static final String ANDROID_LAST_ROW_ID = "last_row_id"; // We ignore all notification with code == 4
        public static final String ANDROID_TEXT_LINE = "android.textLines"; // We ignore all notification with code == 4
    }

    public static final class InterceptedNotificationSharedPref {
        public static final String PREF_IS_CHECKED = "isChecked";
        public static final String PREF_INSTAGRAM_UNAME = "INSTAGRAM_UNAME";
        public static final String PREF_COUNTRY_KEY = "COUNTRY_KEY"; // We ignore all notification with code == 4
        public static final String PREF_SELLER_CHANNEL = "sellerchannel"; // We ignore all notification with code == 4
    }

    private String createNotificationChannel(NotificationManager notificationManager) {
        String channelId = "Gangala_id_one";
        String channelName = "AutoReplay ON";
        NotificationChannel channel = null;
        if (android.os.Build.VERSION.SDK_INT >= android.os.Build.VERSION_CODES.O) {
            channel = new NotificationChannel(channelId, channelName, NotificationManager.IMPORTANCE_HIGH);
            // omitted the LED color
            channel.setImportance(NotificationManager.IMPORTANCE_NONE);
            channel.setLockscreenVisibility(Notification.VISIBILITY_PRIVATE);
            notificationManager.createNotificationChannel(channel);
        }
        return channelId;
    }

    @Override
    public IBinder onBind(Intent intent) {
        return super.onBind(intent);
    }

    @RequiresApi(api = Build.VERSION_CODES.P)
    @Override
    public void onNotificationPosted(StatusBarNotification sbn) {


        SharedPreferences prefs = getSharedPreferences("MY_PREFS_NAME", MODE_PRIVATE);
        if (!prefs.getBoolean(InterceptedNotificationSharedPref.PREF_IS_CHECKED, true)) {
            return;
        }
        if (prefs.getString(InterceptedNotificationSharedPref.PREF_COUNTRY_KEY, null) == null) {
            prefs.edit().putString(InterceptedNotificationSharedPref.PREF_COUNTRY_KEY, getCountryDialCode()).apply();
        }

        boolean isReplyEnable = false;
        Bundle bundle = sbn.getNotification().extras;
        Log.d("TAG", "bundle~~>----" + bundle.toString());
        packageName = sbn.getPackageName();
        if (packageName.equals(BuildConfig.APPLICATION_ID)) {
            return;
        }
        Log.d("TAG", "id~~>1");

        String sender = bundle.getString(InterceptedNotificationParseCode.ANDROID_TITLE);
        String message = "" + bundle.getString(InterceptedNotificationParseCode.ANDROID_TEXT);

//        Log.d("message-=-=-=-111111=-=-=--==-" + message);
        Log.d("TAG", "id~~>2");
        if (sender != null && sender.equals(" ")) {

            Log.d("TAG", "id~~>2222");
            senders = sender.split(":");

            if (senders.length > 1) {
                sender = senders[1];
                sender = sender.replaceAll(" ", "");
            }
        }

        Log.d("TAG", "id~~>3");
        switch (packageName) {

            case ApplicationPackageNames.INSTA_PACKNAME:
                if (!prefs.getBoolean(ApplicationPackageNames.INSTA_PACKNAME, false)) {
                    return;
                }
                CharSequence[] textLine = bundle.getCharSequenceArray(InterceptedNotificationParseCode.ANDROID_TEXT_LINE);
                appendLog("textLine**********1213123132132123*********" + textLine);
                if (textLine != null) {
                    appendLog("textLine*******************" + textLine);
                    String firstUser = textLine[textLine.length - 2].toString().split(":")[0];
                    String secUser = textLine[textLine.length - 1].toString().split(":")[0];
                    if (prefs.getString(InterceptedNotificationSharedPref.PREF_INSTAGRAM_UNAME, null) == null) {
                        if (!firstUser.equalsIgnoreCase(secUser)) {
                            appendLog("secUser*******************" + secUser);
                            appendLog("firstUser*******12121212121************" + firstUser);
                            prefs.edit().putString(InterceptedNotificationSharedPref.PREF_INSTAGRAM_UNAME, secUser).apply();
                        }
                        return;
                    }
                    android.util.Log.d("TAG~~~", "onNotificationPosted: " + prefs.getString(InterceptedNotificationSharedPref.PREF_INSTAGRAM_UNAME, "") + " : " + secUser);
//                    isReplyEnable = true;
                    if (!prefs.getString(InterceptedNotificationSharedPref.PREF_INSTAGRAM_UNAME, "").equalsIgnoreCase(secUser)) {
                        isReplyEnable = true;
                        appendLog("----------isReplyEnable=========" + isReplyEnable);
                    }
                } else {
                    isReplyEnable = true;
                    appendLog("isReplyEnable" + isReplyEnable);
                }
                if (isReplyEnable) {
                    String[] messageStr = message.split(":");
                    message = messageStr[messageStr.length - 1];
                    sender = messageStr[messageStr.length - 2];
                    appendLog("-=-=-=-=-=-=-=-messageStr-=-=-=-=-=-=-" + messageStr);
                    appendLog("-=-=-=-=-=-=-=-message-=-=-=-=-=-=-" + message);
                    appendLog("-=-=-=-=-=-=-=-sender-=-=-=-=-=-=-" + sender);
                }
                Log.d("TAG", "id~~>11");
                break;
            case ApplicationPackageNames.WHATSAPP_PACKNAME:
            case ApplicationPackageNames.WHATSAPP_PACKNAME_BUSINESS:
                Log.d("TAG", "TEST-REPLY 0");
                if (!prefs.getBoolean(ApplicationPackageNames.WHATSAPP_PACKNAME, false)) {
                    Log.d("TAG", "WHATSAPP_PACKNAME_BUSINESS");

                    if (packageName.equals(ApplicationPackageNames.WHATSAPP_PACKNAME))
                        return;
                }
                if (!prefs.getBoolean(ApplicationPackageNames.WHATSAPP_PACKNAME_BUSINESS, false)) {
                    if (packageName.equals(ApplicationPackageNames.WHATSAPP_PACKNAME_BUSINESS))
                        return;
                }
                Log.d("TAG", "TEST-REPLY sender: " + sender);
                if (sender != null && !sender.equalsIgnoreCase("tú") && !sender.equalsIgnoreCase("you")) {
                    Log.d("TAG", "arrayList --1 start");
                    ArrayList<Parcelable> arrayList = bundle.getParcelableArrayList("android.people.list");
                    Log.d("TAG", "arrayList --1 end:" + arrayList);
                    if (arrayList != null && arrayList.size() > 0) {
                        String phoneNo = getphoneNo(((Person) (arrayList.get(0))).getUri());
                        if (!phoneNo.isEmpty()) {
                            sender = phoneNo;
                            appendLog("arrayList----" + arrayList);
                        }
                    }
                    long lastRowId = bundle.getLong(InterceptedNotificationParseCode.ANDROID_LAST_ROW_ID);
                    appendLog("arrayList----lastRowId" + lastRowId);
                    Log.d("TAG", "TEST-REPLY 1 lastRowId: " + lastRowId);
                    if (lastRowId != 0) {
                        if (waLastRawId.size() == 0 || !waLastRawId.contains(lastRowId)) {
                            appendLog("arrayList----lastRowId 0");
                            waLastRawId.add(lastRowId);
                            Log.d("TAG", "TEST-REPLY 2");
                            isReplyEnable = true;
                        }
                    }
                }
                Log.d("TAG", "id~~>21");
                break;
            case ApplicationPackageNames.TWITTER_PACKNAME:
                if (!prefs.getBoolean(ApplicationPackageNames.TWITTER_PACKNAME, false)) {
                    return;
                }
                String[] isGroupCount = message.split(":");
                if (isGroupCount.length > 1) {
                    return;
                }
                isReplyEnable = true;
                Log.d("TAG", "id~~>31");
                break;
            case ApplicationPackageNames.FACEBOOK_PACKNAME:
                if (!prefs.getBoolean(ApplicationPackageNames.FACEBOOK_PACKNAME, false)) {
                    return;
                }
                if (sender != null) {
                    isReplyEnable = true;
                }
                Log.d("TAG", "id~~>41");
                break;
            case ApplicationPackageNames.TELEGRAM_PACKNAME:
                if (!prefs.getBoolean(ApplicationPackageNames.TELEGRAM_PACKNAME, false)) {
                    return;
                }
                if (sender != null) {
                    isReplyEnable = true;
                }
                Log.d("TAG", "id~~>50");
                break;
//            case ApplicationPackageNames.INSTA_PACKNAME:
//                if (!prefs.getBoolean(ApplicationPackageNames.INSTA_PACKNAME, false)) {
//                    return;
//                }
//                if (sender != null) {
//                    isReplyEnable = true;
//                }
//                Log.d("TAG", "id~~>60");
//                break;

        }

        if (isReplyEnable) {

            appendLog("sender----:" + (sender));
            appendLog("message---: " + (message));

            String key = "botMessage-" + message.toLowerCase();
            String repliedMessage = prefs.getString(key, "Hi");

            appendLog("repliedMessage---: " + repliedMessage);
            appendLog("key----------: " + key);


            replayNotification(sbn, bundle, repliedMessage);


//            requestMessage(message, sender).subscribeOn(Schedulers.trampoline())
//                    .observeOn(AndroidSchedulers.mainThread())
//                    .subscribeWith(new DisposableObserver<String>() {
//                        @Override
//                        public void onNext(String object) {
//                            try {
//                                replayNotification(sbn, bundle, object);
//                            } catch (Exception e) {
//                                e.printStackTrace();
//                            }
//                        }
//
//                        @Override
//                        public void onError(Throwable e) {
//                            e.printStackTrace();
//                        }
//
//                        @Override
//                        public void onComplete() {
//                        }
//                    });
        }
        appendLog("packageName ---:" + packageName);
    }

    @SuppressLint("Range")
    public String getphoneNo(String uri) {
        try {

            ContentResolver cr = getContentResolver();
            Cursor cur = cr.query(Uri.parse(uri), null,
                    null, null, null);
            if (cur.getCount() > 0) {
                while (cur.moveToNext()) {
                    @SuppressLint("Range") String id = cur.getString(cur.getColumnIndex(ContactsContract.Contacts._ID));
                    @SuppressLint("Range") String name = cur.getString(cur.getColumnIndex(ContactsContract.Contacts.DISPLAY_NAME));
                    if (Integer.parseInt(cur.getString(cur.getColumnIndex(ContactsContract.Contacts.HAS_PHONE_NUMBER))) > 0) {
                        // Query phone here. Covered next
                        Cursor phones = getContentResolver().query(ContactsContract.CommonDataKinds.Phone.CONTENT_URI, null, ContactsContract.CommonDataKinds.Phone.CONTACT_ID + " = " + id, null, null);
                        while (phones.moveToNext()) {
                            String phoneNumber = phones.getString(phones.getColumnIndex(ContactsContract.CommonDataKinds.Phone.NUMBER));
                            return phoneNumber;
                        }
                        phones.close();
                    }

                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return "";
    }

    public String getCountryDialCode() {
        String contryId = null;
        String contryDialCode = null;

        TelephonyManager telephonyMngr = (TelephonyManager) this.getSystemService(Context.TELEPHONY_SERVICE);

        contryId = telephonyMngr.getSimCountryIso().toUpperCase();
        String[] arrContryCode = this.getResources().getStringArray(R.array.DialingCountryCode);
        for (int i = 0; i < arrContryCode.length; i++) {
            String[] arrDial = arrContryCode[i].split(",");
            if (arrDial[1].trim().equals(contryId.trim())) {
                contryDialCode = arrDial[1];
                break;
            }
        }
        return contryDialCode;
    }

    public Observable<String> requestMessage(String message, String sender) {
        return Observable.create(emitter -> {
            try {
                SharedPreferences prefs = getSharedPreferences("MY_PREFS_NAME", MODE_PRIVATE);

                String baseUrl = "";
                String contryCode = "IN";
                if (prefs.getString("getLanguage", "CO").equalsIgnoreCase("CO")) {
                    baseUrl = "http://194.195.119.55:5001/";
                    contryCode = "CO";
                } else {
                    baseUrl = "http://194.195.119.55:5000/";
                }
                Log.d("TAG", "id~~>61" + baseUrl);
                Retrofit retrofit = new Retrofit.Builder().baseUrl(baseUrl)
                        .addConverterFactory(GsonConverterFactory.create())
                        .build();

                appendLog("Message>>>" + message);
                appendLog("sender>>>" + sender + "_" + contryCode);
                appendLog("sellerchannel>>>" + prefs.getString(InterceptedNotificationSharedPref.PREF_SELLER_CHANNEL, "yo"));
                Map<String, Object> jsonParams = new ArrayMap<>();
                jsonParams.put("message", message);
                jsonParams.put("sender", sender + "_" + contryCode);
                Map<String, Object> matadata = new ArrayMap<>();
                matadata.put("sellerchannel", prefs.getString(InterceptedNotificationSharedPref.PREF_SELLER_CHANNEL, ""));
                matadata.put("buyer_name", "Na");
                matadata.put("buyer_email", "Na");
                matadata.put("buyer_city", "Na");
                matadata.put("buyer_street", "Na");
                jsonParams.put("metadata", matadata);
                appendLog("Send>>> 0");
                RequestBody body = RequestBody.create(okhttp3.MediaType.parse("application/json; charset=utf-8"), (new JSONObject(jsonParams)).toString());

                APIinterface apiService = retrofit.create(APIinterface.class);
                Call<ResponseBody> response = apiService.requestAd(body);
                appendLog("Send>>> 1");
                response.enqueue(new Callback<ResponseBody>() {
                    @Override
                    public void onResponse(Call<ResponseBody> call, Response<ResponseBody> response) {
                        appendLog("Send>>> 2 onResponse");
                        if (response.isSuccessful() && response.body() != null) {
                            appendLog("Send>>> 3");
                            try {
                                appendLog("Send>>> 4");
                                emitter.onNext(response.body().string());
                            } catch (IOException e) {
                                appendLog("Send>>> 5");
                                e.printStackTrace();
                            }
                        }
                    }

                    @Override
                    public void onFailure(Call<ResponseBody> call, Throwable t) {
                        appendLog("Send>>> 2 onFailure");
                        if (t instanceof SocketTimeoutException) {
                            // "Connection Timeout";
                            appendLog("Send>>> 2 onFailure SocketTimeoutException");
                        } else if (t instanceof IOException) {
                            // "Timeout";
                            appendLog("Send>>> 2 onFailure IOException");
                        } else {
                            emitter.onError(t);
                            appendLog("Send>>> 2 onFailure elseException");
                        }
                    }
                });
            } catch (Exception e) {
                emitter.onError(e);
                appendLog("Send>>> main exception: " + e.getLocalizedMessage());
                e.getLocalizedMessage();
            }
        });
    }


    @RequiresApi(api = Build.VERSION_CODES.KITKAT_WATCH)
    private void replayNotification(StatusBarNotification statusBarNotification, Bundle bundle, String messages) {
        RemoteInput[] remoteInputArr = new RemoteInput[0];
        Intent intent = new Intent();
        appendLog("intent--------");
        intent.setFlags(Intent.FLAG_RECEIVER_FOREGROUND);
        appendLog("intent.setFlags-----------");
        PendingIntent pendingIntent = null;
        appendLog("-----------remoteInputArr");
        if (Build.VERSION.SDK_INT >= 24) {
            appendLog("Build.VERSION.SDK_INT-----------");
            Notification.Action[] actionArr = statusBarNotification.getNotification().actions;
            if (actionArr == null) {
                return;
            }
            for (Notification.Action action : actionArr) {
                if (!(action == null || action.getRemoteInputs() == null)) {
                    remoteInputArr = action.getRemoteInputs();
                    pendingIntent = action.actionIntent;
                }
            }
            for (RemoteInput remoteInput : remoteInputArr) {
                bundle.putCharSequence(remoteInput.getResultKey(), messages);
            }
        } else {
            for (Notification.Action action2 : new Notification.WearableExtender(statusBarNotification.getNotification()).getActions()) {
                if (!(action2 == null || action2.getRemoteInputs() == null)) {
                    remoteInputArr = action2.getRemoteInputs();
                    pendingIntent = action2.actionIntent;
                }
            }
            for (RemoteInput remoteInput2 : remoteInputArr) {
                bundle.putCharSequence(remoteInput2.getResultKey(), messages);
            }
        }

        RemoteInput.addResultsToIntent(remoteInputArr, intent, bundle);
        if (pendingIntent != null) {
            try {
                switch (packageName) {
                    case ApplicationPackageNames.INSTA_PACKNAME:

                        SharedPreferences prefInsta = getSharedPreferences("MY_PREFS_NAME", MODE_PRIVATE);
                        int instaCount = prefInsta.getInt("instaMessageCount", 0);
                        instaCount = instaCount + 1;
                        prefInsta.edit().putInt("instaMessageCount", instaCount).apply();
                        break;

                    case ApplicationPackageNames.TELEGRAM_PACKNAME:

                        SharedPreferences prefsTelegram = getSharedPreferences("MY_PREFS_NAME", MODE_PRIVATE);
                        int telegramCount = prefsTelegram.getInt("telegramMessageCount", 0);
                        telegramCount = telegramCount + 1;

                        Log.d("TAG", "telegramCount~~ 0" + telegramCount);

                        prefsTelegram.edit().putInt("telegramMessageCount", telegramCount).apply();
                        break;


                    case ApplicationPackageNames.FACEBOOK_PACKNAME:
                        Log.d("TAG", "FACEBOOK_PACKNAME~~ 0");

                        SharedPreferences prefsFacebook = getSharedPreferences("MY_PREFS_NAME", MODE_PRIVATE);
                        int facebookCount = prefsFacebook.getInt("facebookMessageCount", 0);
                        Log.d("TAG", "FACEBOOK_PACKNAME~~ 1" + facebookCount);

                        facebookCount = facebookCount + 1;
                        Log.d("TAG", "FACEBOOK_PACKNAME~~ 2" + facebookCount);

                        prefsFacebook.edit().putInt("facebookMessageCount", facebookCount).apply();
                        Log.d("TAG", "FACEBOOK_PACKNAME~~ 3" + pendingIntent);

                        pendingIntent.send(this, 0, intent);
                        Log.d("TAG", "FACEBOOK_PACKNAME~~ 4" + facebookCount);
                        break;


                    case ApplicationPackageNames.TWITTER_PACKNAME:

                        SharedPreferences prefsTwitter = getSharedPreferences("MY_PREFS_NAME", MODE_PRIVATE);
                        int twitterCount = prefsTwitter.getInt("twitterMessageCount", 0);
                        twitterCount = twitterCount + 1;
                        prefsTwitter.edit().putInt("twitterMessageCount", twitterCount).apply();
                        break;


                    case ApplicationPackageNames.WHATSAPP_PACKNAME_BUSINESS:

                        SharedPreferences prefsWhatsappBusi = getSharedPreferences("MY_PREFS_NAME", MODE_PRIVATE);
                        int whatsappBusinessCount = prefsWhatsappBusi.getInt("whatsAppBusinessMessageCount", 0);
                        whatsappBusinessCount = whatsappBusinessCount + 1;
                        prefsWhatsappBusi.edit().putInt("whatsAppBusinessMessageCount", whatsappBusinessCount).apply();
                        break;


                    case ApplicationPackageNames.WHATSAPP_PACKNAME:

                        SharedPreferences prefsWhatsapp = getSharedPreferences("MY_PREFS_NAME", MODE_PRIVATE);
                        int whatsappCount = prefsWhatsapp.getInt("messageCount", 0);
                        whatsappCount = whatsappCount + 1;
                        prefsWhatsapp.edit().putInt("messageCount", whatsappCount).apply();
                        break;

                }

                /*SharedPreferences prefs = getSharedPreferences("MY_PREFS_NAME", MODE_PRIVATE);
                int messageCount = prefs.getInt("messageCount", 0);
                messageCount = messageCount + 1;
                prefs.edit().putInt("messageCount", messageCount).apply();*/

                pendingIntent.send(this, 0, intent);

            } catch (PendingIntent.CanceledException e2) {
                e2.printStackTrace();
            }
        }
        appendLog("-----------RemoteInput.addResultsToIntent");
    }


    @Override
    public void onNotificationRemoved(StatusBarNotification sbn) {
        int notificationCode = matchNotificationCode(sbn);

        if (notificationCode != InterceptedNotificationCode.OTHER_NOTIFICATIONS_CODE) {

            StatusBarNotification[] activeNotifications = this.getActiveNotifications();

            if (activeNotifications != null && activeNotifications.length > 0) {
                for (int i = 0; i < activeNotifications.length; i++) {
                    if (notificationCode == matchNotificationCode(activeNotifications[i])) {

                        break;
                    }
                }
            }
        }
    }

    private int matchNotificationCode(StatusBarNotification sbn) {
        String packageName = sbn.getPackageName();

        if (packageName.equals(ApplicationPackageNames.WHATSAPP_PACKNAME)) {
            return (InterceptedNotificationCode.WHATSAPP_CODE);
        } else {
            return (InterceptedNotificationCode.OTHER_NOTIFICATIONS_CODE);
        }
    }


    public void appendLog(String text) {
        Log.d("TAG", "appendLog~~>" + text);
//        File logFile = new File(Environment.getExternalStoragePublicDirectory(Environment.DIRECTORY_DOWNLOADS) + "/Gangala.file");
//        if (!logFile.exists()) {
//            try {
//                logFile.createNewFile();
//            } catch (IOException e) {
//                // TODO Auto-generated catch block
//                e.printStackTrace();
//            }
//        }
//        try {
//            //BufferedWriter for performance, true to set append to file flag
//            BufferedWriter buf = new BufferedWriter(new FileWriter(logFile, true));
//            buf.append(text);
//            buf.newLine();
//            buf.close();
//        } catch (IOException e) {
//            // TODO Auto-generated catch block
//            e.printStackTrace();
//        }
    }
}