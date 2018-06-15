import 'dart:async';
import 'package:flutter/services.dart';
import 'package:flutter/material.dart';
import 'package:selfbet/models/models.dart';

class NativeCodeRepo {
  static const platform = const MethodChannel("selfbet.axmx.ca");

  Future<void> setAlarm(Bet bet) async {
    try {
      platform.invokeMethod("setAlarm", bet.options).then((value) {
        debugPrint(value);
      });
    } catch (e) {
      print(e);
    }

  }
}