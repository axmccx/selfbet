import 'package:meta/meta.dart';
import 'package:selfbet/models/models.dart';

@immutable
class BetTransact {
  final String uid;
  final int amount;
  final String groupName;
  final BetType betType;
  final DateTime date;
  final bool isWon;
  final Map calcedAtStake;
  final Map recipients;

  BetTransact({
    this.uid,
    this.amount,
    this.groupName,
    this.betType,
    this.date,
    this.isWon,
    this.calcedAtStake,
    this.recipients,
  });

  BetTransact copyWith({
    String uid,
    int amount,
    String groupName,
    BetType betType,
    DateTime date,
    bool isWon,
    Map calcedAtStake,
    Map recipients,
  }) {
    return BetTransact(
      uid: uid ?? this.uid,
      amount: amount ?? this.amount,
      groupName: groupName ?? this.groupName,
      betType: betType ?? this.betType,
      date: date ?? this.date,
      isWon: isWon ?? this.isWon,
      calcedAtStake: calcedAtStake ?? this.calcedAtStake,
      recipients: recipients ?? this.recipients,
    );
  }

  @override
  int get hashCode =>
      uid.hashCode ^
      amount.hashCode ^
      groupName.hashCode ^
      betType.hashCode ^
      date.hashCode ^
      isWon.hashCode ^
      calcedAtStake.hashCode ^
      recipients.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
          other is BetTransact &&
              runtimeType == other.runtimeType &&
              uid == other.uid &&
              amount == other.amount &&
              groupName == other.groupName &&
              betType == other.betType &&
              date == other.date &&
              isWon == other.isWon &&
              calcedAtStake == other.calcedAtStake &&
              recipients == other.recipients;

  Map<String, Object> toJson() {
    return {
      "uid": uid,
      "amount": amount,
      "groupName": groupName,
      "betType": betType,
      "date": date,
      "isWOn": isWon,
      "calcedAtStake": calcedAtStake,
      "recipients": recipients,
    };
  }

  @override
  String toString() {
    return 'Transaction{'
        'uid: $uid, '
        'amout: $amount, '
        'groupName: $groupName, '
        'betType: $betType, '
        'date: $date, '
        'isWon: $isWon, '
        'calcedAtStake, $calcedAtStake, '
        'recipients: $recipients,'
        '}';
  }
}