package com.hmi.firebase_notification

import android.app.NotificationChannel
import android.app.NotificationManager

object NotificationChannels {

    val highImportanceChannel = NotificationChannel(
        "high_importance_channel",
        "High Importance Channel",
        NotificationManager.IMPORTANCE_HIGH,
    ).apply {
        description = "This is high importance channel"
        // vibrationPattern = longArrayOf(0, 1000, 500, 1000, 500)
        setShowBadge(true)
        enableVibration(true)
    }

    val lowImportanceChannel = NotificationChannel(
        "low_importance_channel",
        "Low Importance Channel",
        NotificationManager.IMPORTANCE_LOW,
    ).apply {
        description = "This is low importance channel"
        // vibrationPattern = longArrayOf(0, 500, 500)
        setShowBadge(true)
        enableVibration(true)
    }

    val normalImportanceChannel = NotificationChannel(
        "normal_importance_channel",
        "Normal Importance Channel",
        NotificationManager.IMPORTANCE_DEFAULT,
    ).apply {
        description = "This is normal importance channel"
        // vibrationPattern = longArrayOf(0, 500, 500, 500)
        setShowBadge(true)
        enableVibration(true)
    }
}