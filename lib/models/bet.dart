import 'package:meta/meta.dart';
import 'package:selfbet/models/models.dart';

@immutable
class Bet {
  final int amount;
  final String groupName;
  final BetType type;
  final bool isExpired;
  final DateTime expiryDate;
  final Map options;

  Bet({
    this.amount,
    this.groupName,
    this.type,
    this.isExpired,
    this.expiryDate,
    this.options,
  });

  Bet copyWith({
    int amount,
    Group group,
    BetType type,
    bool isExpired,
    DateTime expiryDate,
    Map options,
  }) {
    return Bet(
      amount: amount ?? this.amount,
      groupName: groupName ?? this.groupName,
      type: type ?? this.type,
      isExpired: isExpired ?? this.isExpired,
      expiryDate: expiryDate ?? this.expiryDate,
      options: options ?? this.options,
    );
  }

  @override
  int get hashCode =>
      amount.hashCode ^
      groupName.hashCode ^
      type.hashCode ^
      isExpired.hashCode ^
      expiryDate.hashCode ^
      options.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
          other is Bet &&
              runtimeType == other.runtimeType &&
              amount == other.amount &&
              groupName == other.groupName &&
              type == other.type &&
              isExpired == other.isExpired &&
              expiryDate == other.expiryDate &&
              options == other.options;

  Map<String, Object> toJson() {
    return {
      "amount": amount,
      "group": groupName,
      "type": type.toString(),
      "isExpired": isExpired,
      "expiryDate": expiryDate.toIso8601String(),
      "options": options,
      // user
    };
  }

  @override
  String toString() {
    return 'Bet{'
        'Amount: $amount, '
        'groupName: $groupName, '
        'Type: $type, '
        'isExpired: $isExpired, '
        'expiryDate: $expiryDate, '
        'options: $options'
        '}';
  }
}