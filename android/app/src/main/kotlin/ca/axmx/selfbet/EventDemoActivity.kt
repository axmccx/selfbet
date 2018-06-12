package ca.axmx.selfbet

import android.os.Bundle
import android.support.v4.app.FragmentActivity
import android.util.Log


class EventDemoActivity : FragmentActivity() {
    public override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        Log.d("EventDemoActivity", "Triggered")
    }
}