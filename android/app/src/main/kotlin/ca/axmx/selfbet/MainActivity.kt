package ca.axmx.selfbet

import android.os.Bundle

import io.flutter.app.FlutterActivity
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugins.GeneratedPluginRegistrant

class MainActivity : FlutterActivity() {
  private val CHANNEL = "selfbet.axmx.ca"

  override fun onCreate(savedInstanceState: Bundle?) {
    super.onCreate(savedInstanceState)
    GeneratedPluginRegistrant.registerWith(this)

    MethodChannel(flutterView, CHANNEL).setMethodCallHandler { call, result ->

        val hour: Int = call.argument<Int>("hour")
        val minutes: Int = call.argument<Int>("minutes")

        if (call.method == "setAlarm")  {
            result.success("Native code sets the alarm for $hour:$minutes")
        }
    }
  }
}
