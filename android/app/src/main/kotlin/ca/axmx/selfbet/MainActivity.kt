package ca.axmx.selfbet

import android.app.AlarmManager
import android.app.PendingIntent
import android.content.Context
import android.content.Intent
import android.os.Bundle

import io.flutter.app.FlutterActivity
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugins.GeneratedPluginRegistrant
import java.util.*

class MainActivity(): FlutterActivity() {
  private val CHANNEL = "selfbet.axmx.ca"
    var notificationId = 0

  override fun onCreate(savedInstanceState: Bundle?) {
    super.onCreate(savedInstanceState)
    GeneratedPluginRegistrant.registerWith(this)

    MethodChannel(flutterView, CHANNEL).setMethodCallHandler { call, result ->

        val hour: Int = call.argument<Int>("hour")
        val minutes: Int = call.argument<Int>("minutes")

        if (call.method == "setAlarm")  {
            val alarmManager = getSystemService(Context.ALARM_SERVICE) as AlarmManager
            val calendar = Calendar.getInstance()
            calendar.add(Calendar.SECOND, 20)
            alarmManager.setAlarmClock(
                    AlarmManager.AlarmClockInfo(
                            calendar.timeInMillis,
                            PendingIntent.getBroadcast(
                                    applicationContext,
                                    notificationId,
                                    Intent(applicationContext, EventDemoActivity::class.java),
                                    PendingIntent.FLAG_UPDATE_CURRENT
                            )
                    ),
                    PendingIntent.getBroadcast(
                            applicationContext,
                            notificationId,
                            Intent(applicationContext, EventDemoActivity::class.java),
                            PendingIntent.FLAG_UPDATE_CURRENT
                    )
            )
            result.success("Native code set the alarm for $hour:$minutes")
        }
    }
  }
}
