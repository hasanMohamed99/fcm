package com.hmi.firebase_notification
import android.app.NotificationManager
import android.content.Intent
import android.os.Build
import android.os.Bundle
import io.flutter.embedding.android.FlutterFragmentActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel
import java.io.Serializable

class MainActivity : FlutterFragmentActivity() {

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        createNotificationChannel()
    }

    private val notificationChannel = "com.firebase.notification.app"

    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)
        MethodChannel(
            flutterEngine.dartExecutor.binaryMessenger,
            notificationChannel
        ).setMethodCallHandler { call, result ->
            when (call.method) {
                "showNotification" -> {
                    if (call.arguments != null) {
                        val args = call.arguments as Map<*, *>
//                        showNotification(
//                            args
//                        )
                        showCallNotification(args)
                        result.success(null)
                    }
                }

                else -> {
                    result.notImplemented()
                }
            }
        }
    }

    private fun showCallNotification(args: Map<*, *>) {
        val serializableMap = args as Serializable
        val serviceIntent = Intent(this, CallNotificationService::class.java).apply {
            putExtra("data", serializableMap)
        }
        this.startForegroundService(serviceIntent)
    }
    private fun showNotification(args: Map<*, *>) {
        val handler = NotificationHandler(applicationContext)
        handler.showNotification(args)
    }

    private fun createNotificationChannel() {

        getSystemService(NotificationManager::class.java)
            .createNotificationChannels(
                listOf(
                    NotificationChannels.highImportanceChannel,
                    NotificationChannels.normalImportanceChannel,
                    NotificationChannels.lowImportanceChannel,
                )
            )
    }

}
