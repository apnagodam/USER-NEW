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
            
            val audioAttributes = AudioAttributes.Builder()
                .setContentType(AudioAttributes.CONTENT_TYPE_SONIFICATION)
                .setUsage(AudioAttributes.USAGE_NOTIFICATION)
                .build()

            val coinResId = try { R.raw.coin_dropping } catch (e: Exception) { resources.getIdentifier("coin_dropping", "raw", packageName) }
            val iplResId = try { R.raw.ipl_message } catch (e: Exception) { resources.getIdentifier("ipl_message", "raw", packageName) }
            val templeBellResId = try { R.raw.temple_bell } catch (e: Exception) { resources.getIdentifier("temple_bell", "raw", packageName) }

            val coinSoundUri = if (coinResId != 0) Uri.parse("android.resource://$packageName/$coinResId") else Uri.parse("android.resource://$packageName/raw/coin_dropping")
            val iplSoundUri = if (iplResId != 0) Uri.parse("android.resource://$packageName/$iplResId") else Uri.parse("android.resource://$packageName/raw/ipl_message")
            val templeBellSoundUri = if (templeBellResId != 0) Uri.parse("android.resource://$packageName/$templeBellResId") else Uri.parse("android.resource://$packageName/raw/temple_bell")

            // Delete any existing stale channels so new settings with sound take effect
            try {
                notificationManager.deleteNotificationChannel("high_importance_channel")
                notificationManager.deleteNotificationChannel("coin_dropping_channel")
                notificationManager.deleteNotificationChannel("ipl_message_channel")
                notificationManager.deleteNotificationChannel("temple_bell_channel")
                notificationManager.deleteNotificationChannel("custom_sound_channel")
                notificationManager.deleteNotificationChannel("high_importance_channel_v2")
                notificationManager.deleteNotificationChannel("coin_dropping_channel_v2")
                notificationManager.deleteNotificationChannel("ipl_message_channel_v2")
                notificationManager.deleteNotificationChannel("temple_bell_channel_v2")
                notificationManager.deleteNotificationChannel("custom_sound_channel_v2")
            } catch (e: Exception) {
                // Ignore deletion errors
            }

            // 1. High importance default channel v3
            val highImportanceChannelV3 = NotificationChannel(
                "high_importance_channel_v3",
                "High Importance Notifications",
                NotificationManager.IMPORTANCE_HIGH
            ).apply {
                description = "This channel is used for important notifications."
                setSound(coinSoundUri, audioAttributes)
                enableVibration(true)
                enableLights(true)
            }

            // 2. Coin Dropping channel v3
            val coinDroppingChannelV3 = NotificationChannel(
                "coin_dropping_channel_v3",
                "Coin Dropping Notifications",
                NotificationManager.IMPORTANCE_HIGH
            ).apply {
                description = "Notifications with coin dropping sound"
                setSound(coinSoundUri, audioAttributes)
                enableVibration(true)
                enableLights(true)
            }

            // 3. IPL Message channel v3
            val iplChannelV3 = NotificationChannel(
                "ipl_message_channel_v3",
                "IPL Message Notifications",
                NotificationManager.IMPORTANCE_HIGH
            ).apply {
                description = "Notifications with IPL message sound"
                setSound(iplSoundUri, audioAttributes)
                enableVibration(true)
                enableLights(true)
            }
            
            // 4. Temple Bell channel v3
            val templeBellChannelV3 = NotificationChannel(
                "temple_bell_channel_v3",
                "Temple Bell Notifications",
                NotificationManager.IMPORTANCE_HIGH
            ).apply {
                description = "Notifications with temple bell sound"
                setSound(templeBellSoundUri, audioAttributes)
                enableVibration(true)
                enableLights(true)
            }
            
            // 5. Custom channel v3
            val customChannelV3 = NotificationChannel(
                "custom_sound_channel_v3",
                "Custom Sound Notifications",
                NotificationManager.IMPORTANCE_HIGH
            ).apply {
                description = "Notifications with custom sounds"
                setSound(coinSoundUri, audioAttributes)
                enableVibration(true)
                enableLights(true)
            }

            // Register v3 channels
            notificationManager.createNotificationChannel(highImportanceChannelV3)
            notificationManager.createNotificationChannel(coinDroppingChannelV3)
            notificationManager.createNotificationChannel(iplChannelV3)
            notificationManager.createNotificationChannel(templeBellChannelV3)
            notificationManager.createNotificationChannel(customChannelV3)

            // Re-create v2 and base channels with sound in case backend sends old channel names
            val highImportanceChannelV2 = NotificationChannel(
                "high_importance_channel_v2",
                "High Importance Notifications",
                NotificationManager.IMPORTANCE_HIGH
            ).apply {
                description = "This channel is used for important notifications."
                setSound(coinSoundUri, audioAttributes)
                enableVibration(true)
                enableLights(true)
            }

            val coinDroppingChannelV2 = NotificationChannel(
                "coin_dropping_channel_v2",
                "Coin Dropping Notifications",
                NotificationManager.IMPORTANCE_HIGH
            ).apply {
                description = "Notifications with coin dropping sound"
                setSound(coinSoundUri, audioAttributes)
                enableVibration(true)
                enableLights(true)
            }

            val iplChannelV2 = NotificationChannel(
                "ipl_message_channel_v2",
                "IPL Message Notifications",
                NotificationManager.IMPORTANCE_HIGH
            ).apply {
                description = "Notifications with IPL message sound"
                setSound(iplSoundUri, audioAttributes)
                enableVibration(true)
                enableLights(true)
            }

            val templeBellChannelV2 = NotificationChannel(
                "temple_bell_channel_v2",
                "Temple Bell Notifications",
                NotificationManager.IMPORTANCE_HIGH
            ).apply {
                description = "Notifications with temple bell sound"
                setSound(templeBellSoundUri, audioAttributes)
                enableVibration(true)
                enableLights(true)
            }

            val customChannelV2 = NotificationChannel(
                "custom_sound_channel_v2",
                "Custom Sound Notifications",
                NotificationManager.IMPORTANCE_HIGH
            ).apply {
                description = "Notifications with custom sounds"
                setSound(coinSoundUri, audioAttributes)
                enableVibration(true)
                enableLights(true)
            }

            notificationManager.createNotificationChannel(highImportanceChannelV2)
            notificationManager.createNotificationChannel(coinDroppingChannelV2)
            notificationManager.createNotificationChannel(iplChannelV2)
            notificationManager.createNotificationChannel(templeBellChannelV2)
            notificationManager.createNotificationChannel(customChannelV2)
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
