package ca.axmx.selfbet

import android.os.Bundle
import android.util.Log

import io.flutter.app.FlutterActivity
import io.flutter.plugins.GeneratedPluginRegistrant
import io.flutter.plugins.androidalarmmanager.AlarmService
import io.flutter.view.FlutterNativeView

class MainActivity : FlutterActivity() {

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        GeneratedPluginRegistrant.registerWith(this)
    }

    override fun createFlutterNativeView(): FlutterNativeView? {
        Log.i(TAG, "createFlutterNativeView")
        return AlarmService.getSharedFlutterView()
    }

    companion object {
        var TAG = "SelfbetMainActivity"
    }
}
