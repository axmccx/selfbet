import 'dart:async';
import 'package:flutter/services.dart';
import 'package:flutter/material.dart';
import 'package:vibrate/vibrate.dart';
import 'package:selfbet/models/models.dart';

class NativeCodeRepo {
  //static const _channel = const MethodChannel("selfbet.axmx.ca");
//  Future<void> setAlarm(Bet bet) async {
//    // determine delay from bet.options
//    // using hard coded 10 seconds for testing
//    final Duration delay = const Duration(seconds: 10);
//    final int now = new DateTime.now().millisecondsSinceEpoch;
//    final int time = now + delay.inMilliseconds;
//
//    _channel.setMethodCallHandler((MethodCall call) {
//      switch (call.method) {
//        case 'firedWhileApplicationRunning':
//          alarmAlert();
//          return;
//        default:
//          throw 'not implemented';
//      }
//    });
//    final dynamic result = await _channel.invokeMethod(
//        'setAlarm',
//        [0, time, "alarmAlert"]
//    );
//    return (result == null) ? false : result;
//  }
//
//  void alarmAlert() {
//    debugPrint("Sounds alarm!! Ring ring!");
//    SystemSound.play(SystemSoundType.click);
//    Vibrate.vibrate();
//  }
}