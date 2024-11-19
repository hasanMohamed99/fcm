package com.hmi.firebase_notification

import io.flutter.embedding.android.FlutterActivity
import android.app.NotificationChannel
import android.app.NotificationManager
import android.os.Bundle

class MainActivity: FlutterActivity(){

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        createNotificationChannel()
    }

    private fun createNotificationChannel() {
        val highImportanceChannel = NotificationChannel(
            "high_importance_channel",
            "High Importance Channel",
            NotificationManager.IMPORTANCE_HIGH,
        ).apply {
            description = "This is high importance channel"
            setShowBadge(true)
            vibrationPattern = longArrayOf(0, 1000, 500, 1000, 500)
            enableVibration(true)
        }

        val lowImportanceChannel = NotificationChannel(
            "low_importance_channel",
            "Low Importance Channel",
            NotificationManager.IMPORTANCE_LOW,
        ).apply {
            description = "This is low importance channel"
            setShowBadge(true)
            vibrationPattern = longArrayOf(0, 500, 500)
            enableVibration(true)
        }
        val manager = getSystemService(NotificationManager::class.java)
        manager.createNotificationChannels(listOf(highImportanceChannel, lowImportanceChannel))
    }
}
