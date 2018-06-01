import 'package:meta/meta.dart';
import 'package:selfbet/models/models.dart';

@immutable
class BetTransact {
  final String uid;
  final int amount;
  final String groupName;
  final BetType betType;
  final int date;
  final bool isWon;
  final Map recipients;

  BetTransact({
    this.uid,
    this.amount,
    this.groupName,
    this.betType,
    this.date,
    this.isWon,
    this.recipients,
  });

  BetTransact copyWith({
    String uid,
    int amount,
    String groupName,
    BetType betType,
    int date,
    bool isWon,
    Map recipents,
  }) {
    return BetTransact(
      uid: uid ?? this.uid,
      amount: amount ?? this.amount,
      groupName: groupName ?? this.groupName,
      betType: betType ?? this.betType,
      date: date ?? this.date,
      isWon: isWon ?? this.isWon,
      recipients: recipents ?? this.recipients,
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
              recipients == other.recipients;

  Map<String, Object> toJson() {
    return {
      "uid": uid,
      "amount": amount,
      "groupName": groupName,
      "betType": betType,
      "date": date,
      "isWOn": isWon,
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
        'recipients: $recipients,'
        '}';
  }
}