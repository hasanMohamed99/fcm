package com.hmi.firebase_notification

import android.app.Notification
import android.app.PendingIntent
import android.app.Service
import android.content.Intent
import android.graphics.drawable.Icon
import android.os.IBinder
import androidx.core.app.NotificationCompat
import androidx.core.app.Person
import androidx.core.graphics.drawable.IconCompat
import kotlinx.coroutines.CoroutineScope
import kotlinx.coroutines.Dispatchers
import kotlinx.coroutines.launch
import kotlinx.coroutines.withContext

class CallNotificationService : Service() {

    override fun onStartCommand(intent: Intent?, flags: Int, startId: Int): Int {
        // Build and show the call-style notification
        val map = intent?.getSerializableExtra("data") as Map<*, *>
        val notification = createCallNotification(map)
        startForeground(1001, notification) // Required to mark this as a foreground service
        return START_NOT_STICKY
    }

    private fun createCallNotification(arguments: Map<*, *>): Notification {
        val title = arguments["title"] as? String
        val text = arguments["text"] as? String
        val imageLink = arguments["image"] as? String
        val channelId = arguments["channel_id"] as String
        val sender = arguments["sender"] as String
        val callIntent = Intent(this, MainActivity::class.java)
        val pendingIntent = PendingIntent.getActivity(this, 0, callIntent, PendingIntent.FLAG_IMMUTABLE)

        val icon = IconCompat.createFromIcon(this, Icon.createWithResource(this, R.drawable.person))

        val declineIntent = PendingIntent.getActivity(
            this,
            1,
            callIntent,
            PendingIntent.FLAG_IMMUTABLE
        )
        val answerIntent = PendingIntent.getActivity(
            this,
            1,
            callIntent,
            PendingIntent.FLAG_IMMUTABLE
        )

        val caller = Person.Builder()
            // Caller icon
            .setIcon(icon)
            // Caller name
            .setName(sender)
            .setImportant(true)
            .build()
        val notificationStyle = NotificationCompat.CallStyle.forIncomingCall(caller, declineIntent, answerIntent)

        return NotificationCompat.Builder(this, channelId)
            .setForegroundServiceBehavior(NotificationCompat.FOREGROUND_SERVICE_IMMEDIATE)
            .setPriority(NotificationCompat.PRIORITY_HIGH)
            .setContentIntent(pendingIntent)
            .setFullScreenIntent(pendingIntent,true)
            .setSmallIcon(R.drawable.ic_notification)
            .setContentTitle(title)
            .setContentText(text)
            .setStyle(
                notificationStyle
            )
            .setSound(null)
            .setOngoing(true)
            .setCategory(Notification.CATEGORY_CALL).build()
    }

    override fun onBind(intent: Intent?): IBinder? = null
}
