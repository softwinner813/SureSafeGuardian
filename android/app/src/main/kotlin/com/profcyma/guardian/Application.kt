package com.profcyma.guardian

import android.app.NotificationChannel
import android.app.NotificationManager
import android.content.Intent
import android.os.Build
import androidx.core.content.ContextCompat
import butterknife.internal.Constants
import com.profcyma.guardian.AuthDetail.getInstance
import io.flutter.app.FlutterApplication


class Application : FlutterApplication() {
    override fun onCreate() {
        super.onCreate()
        //        FlutterFirebaseMessagingService.setPluginRegistrant(this);
        if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.O) {
            val notificationManager = getSystemService(NotificationManager::class.java) as NotificationManager
            notificationManager.createNotificationChannel(
                    NotificationChannel(com.profcyma.guardian.Constants.getInstance().packageName,
                            com.profcyma.guardian.Constants.getInstance().noitfyChannelId,
                            NotificationManager.IMPORTANCE_LOW))
        }
        val bgServiceIntent = Intent(this,
                BackgroundService::class.java)
        bgServiceIntent.putExtra("USER_ID", "")
        bgServiceIntent.putExtra("PASSWORD", "")
        try {
            if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.O) {
                //ContextCompat.startForegroundService(this,bgServiceIntent)
            } else {
                //startService(bgServiceIntent)
            }
        }catch (e : Exception){
            print("error $e")
        }
    }

    //    @Override
    //    public void registerWith(PluginRegistry registry) {
    //        GeneratedPluginRegistrant.registerWith();
    //    }
    override fun onTerminate() {
        super.onTerminate()
    }
}