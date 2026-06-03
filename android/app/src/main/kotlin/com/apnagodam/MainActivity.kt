package com.apnagodam

import android.Manifest
import android.app.NotificationChannel
import android.app.NotificationManager
import android.content.Context
import android.media.AudioAttributes
import android.net.Uri
import android.os.Build
import android.os.Bundle
import android.telephony.TelephonyManager
import androidx.annotation.RequiresPermission
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel

class MainActivity: FlutterActivity() {
    private val CHANNEL = "com.apnagodam/phone"

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        
        // Create notification channel for custom sounds (Android 8.0+)
        if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.O) {
            createNotificationChannels()
        }
    }
    
    private fun createNotificationChannels() {
        if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.O) {
            val notificationManager = getSystemService(NOTIFICATION_SERVICE) as NotificationManager
            
            // Create IPL Message notification channel
            val iplChannelId = "ipl_message_channel"
            val iplChannelName = "IPL Message Notifications"
            val iplChannel = NotificationChannel(
                iplChannelId,
                iplChannelName,
                NotificationManager.IMPORTANCE_HIGH
            ).apply {
                description = "Notifications with IPL message sound"
                
                // Set custom sound for IPL notifications
                val soundUri = Uri.parse("android.resource://$packageName/${R.raw.ipl_message}")
                val audioAttributes = AudioAttributes.Builder()
                    .setContentType(AudioAttributes.CONTENT_TYPE_SONIFICATION)
                    .setUsage(AudioAttributes.USAGE_NOTIFICATION)
                    .build()
                setSound(soundUri, audioAttributes)
                enableVibration(true)
            }
            
            // Create Temple Bell notification channel
            val templeBellChannelId = "temple_bell_channel"
            val templeBellChannelName = "Temple Bell Notifications"
            val templeBellChannel = NotificationChannel(
                templeBellChannelId,
                templeBellChannelName,
                NotificationManager.IMPORTANCE_HIGH
            ).apply {
                description = "Notifications with temple bell sound"
                
                // Set custom sound for temple bell notifications
                val soundUri = Uri.parse("android.resource://$packageName/${R.raw.temple_bell}")
                val audioAttributes = AudioAttributes.Builder()
                    .setContentType(AudioAttributes.CONTENT_TYPE_SONIFICATION)
                    .setUsage(AudioAttributes.USAGE_NOTIFICATION)
                    .build()
                setSound(soundUri, audioAttributes)
                enableVibration(true)
            }
            
            // Create Coin Dropping notification channel
            val coinDroppingChannelId = "coin_dropping_channel"
            val coinDroppingChannelName = "Coin Dropping Notifications"
            val coinDroppingChannel = NotificationChannel(
                coinDroppingChannelId,
                coinDroppingChannelName,
                NotificationManager.IMPORTANCE_HIGH
            ).apply {
                description = "Notifications with coin dropping sound"
                
                // Set custom sound for coin dropping notifications
                val soundUri = Uri.parse("android.resource://$packageName/${R.raw.coin_dropping}")
                val audioAttributes = AudioAttributes.Builder()
                    .setContentType(AudioAttributes.CONTENT_TYPE_SONIFICATION)
                    .setUsage(AudioAttributes.USAGE_NOTIFICATION)
                    .build()
                setSound(soundUri, audioAttributes)
                enableVibration(true)
            }
            
            // Create general custom sound channel
            val customChannelId = "custom_sound_channel"
            val customChannelName = "Custom Sound Notifications"
            val customChannel = NotificationChannel(
                customChannelId,
                customChannelName,
                NotificationManager.IMPORTANCE_HIGH
            ).apply {
                description = "Notifications with custom sounds"
                enableVibration(true)
            }
            
            // Register channels
            notificationManager.createNotificationChannel(iplChannel)
            notificationManager.createNotificationChannel(templeBellChannel)
            notificationManager.createNotificationChannel(coinDroppingChannel)
            notificationManager.createNotificationChannel(customChannel)
        }
    }

 override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
    super.configureFlutterEngine(flutterEngine)
    MethodChannel(
        flutterEngine.dartExecutor.binaryMessenger,
        CHANNEL
    ).setMethodCallHandler { call, result ->  // ← removed @RequiresPermission here
        if (call.method == "getPhoneNumber") {
            val phoneNumber = getPhoneNumber()
            if (phoneNumber != null) {
                result.success(phoneNumber)
            } else {
                result.error("UNAVAILABLE", "Phone number not available", null)
            }
        } else {
            result.notImplemented()
        }
    }
}

    @RequiresPermission(allOf = [Manifest.permission.READ_SMS, Manifest.permission.READ_PHONE_NUMBERS, Manifest.permission.READ_PHONE_STATE])
    private fun getPhoneNumber(): String? {
        val telephonyManager = getSystemService(Context.TELEPHONY_SERVICE) as TelephonyManager
        return telephonyManager.line1Number
    }
}
