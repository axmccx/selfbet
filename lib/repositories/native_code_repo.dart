import 'dart:async';
import 'package:flutter/services.dart';
import 'package:flutter/material.dart';
import 'package:android_alarm_manager/android_alarm_manager.dart';
import 'package:selfbet/models/models.dart';

class NativeCodeRepo {
  static const platform = const MethodChannel("selfbet.axmx.ca");

  Future<void> setAlarm(Bet bet) async {
    await AndroidAlarmManager.oneShot(
      const Duration(seconds: 10),
      0,
      alarmAlert,
      exact: true,
      wakeup: true,
    );
  }

  void alarmAlert() {
    debugPrint("Sounds alarm!! Ring ring!");
    SystemSound.play(SystemSoundType.click);
  }
}