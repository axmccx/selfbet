import 'package:meta/meta.dart';
import 'package:selfbet/models/models.dart';

@immutable
class Bet {
  final String uid;
  final String betId;
  final int amount;
  final String groupName;
  final BetType type;
  final bool isExpired;
  final DateTime expiryDate;
  final bool winCond;
  final Map options;

  Bet({
    this.uid,
    this.betId,
    this.amount,
    this.groupName,
    this.type,
    this.isExpired,
    this.expiryDate,
    this.winCond,
    this.options,
  });

  Bet copyWith({
    String uid,
    String betId,
    int amount,
    Group group,
    BetType type,
    bool isExpired,
    DateTime expiryDate,
    bool winCond,
    Map options,
  }) {
    return Bet(
      uid: uid ?? this.uid,
      betId: betId ?? this.betId,
      amount: amount ?? this.amount,
      groupName: groupName ?? this.groupName,
      type: type ?? this.type,
      isExpired: isExpired ?? this.isExpired,
      expiryDate: expiryDate ?? this.expiryDate,
      winCond: winCond ?? this.winCond,
      options: options ?? this.options,
    );
  }

  @override
  int get hashCode =>
      uid.hashCode ^
      betId.hashCode ^
      amount.hashCode ^
      groupName.hashCode ^
      type.hashCode ^
      isExpired.hashCode ^
      expiryDate.hashCode ^
      winCond.hashCode ^
      options.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
          other is Bet &&
              runtimeType == other.runtimeType &&
              uid == other.uid &&
              betId == other.betId &&
              amount == other.amount &&
              groupName == other.groupName &&
              type == other.type &&
              isExpired == other.isExpired &&
              expiryDate == other.expiryDate &&
              winCond == other.winCond &&
              options == other.options;

  Map<String, Object> toJson() {
    return {
      "uid": uid,
      "uidDate": { uid: DateTime.now().millisecondsSinceEpoch, },
      "amount": amount,
      "group": groupName,
      "type": type.toString(),
      "isExpired": isExpired,
      "expiryDate": expiryDate.millisecondsSinceEpoch,
      "winCond": winCond,
      "options": options,
    };
  }

  @override
  String toString() {
    return 'Bet{'
        'uid: $uid, '
        'betID: $betId, '
        'Amount: $amount, '
        'groupName: $groupName, '
        'Type: $type, '
        'isExpired: $isExpired, '
        'expiryDate: $expiryDate, '
        'winCond: $winCond, '
        'options: $options'
        '}';
  }
}