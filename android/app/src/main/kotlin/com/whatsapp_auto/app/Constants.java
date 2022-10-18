package com.whatsapp_auto.app;

import android.app.PendingIntent;
import android.content.Intent;
import android.os.CountDownTimer;
import android.util.Log;

import java.util.HashMap;

public class Constants {

    public static HashMap<Long, Intent> intentHashMap = new HashMap<>();
    public static HashMap<Long, PendingIntent> pendingIntentHashMap = new HashMap<>();
    public static HashMap<Long, String> packageHashMap = new HashMap<>();

    public static void createTimer(long id, int timer_count, TimerFinishListener timerFinishListener) {
        new CountDownTimer(60000, 30000) {

            @Override
            public void onTick(long l) {
                Log.e("~~~", "timer on tick");
            }

            @Override
            public void onFinish() {
                Log.e("~~~", "timer on finish");
                timerFinishListener.onTimerFinished(id, timer_count);
            }
        }.start();
    }

}