import 'package:flutter/foundation.dart';

class UserEntity {
  final String uid;
  final String name;
  final int balance;
  final int atStake;
  final int amountTrans;

  UserEntity({
    @required this.uid,
    @required this.name,
    @required this.balance,
    @required this.atStake,
    this.amountTrans,
  });

  @override
  int get hashCode =>
      uid.hashCode ^
      name.hashCode ^
      balance.hashCode ^
      atStake.hashCode ^
      amountTrans.hashCode;

  @override
  bool operator ==(other) =>
      identical(this, other) ||
      other is UserEntity &&
          runtimeType == other.runtimeType &&
          uid == other.uid &&
          name == other.name &&
          balance == other.balance &&
          atStake == other.atStake &&
          amountTrans == other.amountTrans;

  @override
  String toString() {
    return 'UserEntity{'
        'uid: $uid, '
        'name: $name, '
        'balance: $balance, '
        'atStake: $atStake, '
        'amountTrans: $amountTrans, '
        '}';
  }
}