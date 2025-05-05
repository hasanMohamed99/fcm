package com.hmi.firebase_notification

import android.app.Notification
import android.app.NotificationManager
import android.app.PendingIntent
import android.content.Context
import android.content.Intent
import android.graphics.Bitmap
import android.graphics.BitmapFactory
import android.graphics.drawable.Icon
import androidx.core.app.NotificationCompat
import androidx.core.app.Person
import androidx.core.graphics.drawable.IconCompat
import kotlinx.coroutines.CoroutineScope
import kotlinx.coroutines.Dispatchers
import kotlinx.coroutines.launch
import kotlinx.coroutines.withContext
import java.net.HttpURLConnection
import java.net.URL

class NotificationHandler(
    private val context: Context,
) {
    private val notificationManager =
        context.getSystemService(Context.NOTIFICATION_SERVICE) as NotificationManager

    fun showNotification(arguments: Map<*, *>) {
        val title = arguments["title"] as? String
        val text = arguments["text"] as? String
        val imageLink = arguments["image"] as? String
        val channelId = arguments["channel_id"] as String
        val sender = arguments["sender"] as String
        val activityIntent = Intent(context, MainActivity::class.java)
        val activityPendingIntent = PendingIntent.getActivity(
            context,
            1,
            activityIntent,
            PendingIntent.FLAG_IMMUTABLE
        )
        val icon = IconCompat.createFromIcon(context, Icon.createWithResource(context, R.drawable.person))
        val person = Person.Builder().setName(sender).setImportant(true).setIcon(icon).build()
        val messageNotificationStyle = NotificationCompat.MessagingStyle(person).addMessage(
            text,
            System.currentTimeMillis(),
            person
        )

        val declineIntent = PendingIntent.getActivity(
            context,
            1,
            activityIntent,
            PendingIntent.FLAG_IMMUTABLE
        )
        val answerIntent = PendingIntent.getActivity(
            context,
            1,
            activityIntent,
            PendingIntent.FLAG_IMMUTABLE
        )
        val callNotificationStyle =
            NotificationCompat.CallStyle.forIncomingCall(person, declineIntent, answerIntent)

        CoroutineScope(Dispatchers.Main).launch {
            val bitmap = withContext(Dispatchers.IO) {
                getBitmapFromUrl(imageLink ?: "")
            }
            val notification = NotificationCompat.Builder(context, channelId)
                .setForegroundServiceBehavior(NotificationCompat.FOREGROUND_SERVICE_IMMEDIATE)
                .setPriority(NotificationCompat.PRIORITY_HIGH)
                .setContentIntent(activityPendingIntent)
                .setSmallIcon(R.drawable.ic_notification)
                .setContentTitle(title)
                .setContentText(text)
                .setStyle(
                    callNotificationStyle
                )
                .setSound(null)
                .setOngoing(true)
                .setCategory(Notification.CATEGORY_CALL)

            notificationManager.notify(1, notification.build())
        }

    }
}

fun getBitmapFromUrl(urlString: String): Bitmap? {
    return try {
        val url = URL(urlString)
        val connection = url.openConnection() as HttpURLConnection
        connection.doInput = true
        connection.connect()
        val inputStream = connection.inputStream
        BitmapFactory.decodeStream(inputStream)
    } catch (e: Exception) {
        e.printStackTrace()
        null
    }
}