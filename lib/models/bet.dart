import 'package:meta/meta.dart';
import 'package:selfbet/models/models.dart';

@immutable
class Bet {
  final int amount;
  final BetType betType;
  final Group group;
  final int occurFreq;
  final int expiry;

  Bet({
    this.amount,
    this.betType,
    this.group,
    this.occurFreq,
    this.expiry,
  });

  Bet copyWith({
    int amount,
    BetType betType,
    Group group,
    int occurFreq,
    int expiry,
  }) {
    return Bet(
      amount: amount ?? this.amount,
      betType: betType ?? this.betType,
      group: group ?? this.group,
      occurFreq: occurFreq ?? this.occurFreq,
      expiry: expiry ?? this.expiry,
    );
  }

  @override
  int get hashCode =>
      amount.hashCode ^
      betType.hashCode ^
      group.hashCode ^
      occurFreq.hashCode ^
      expiry.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
          other is Bet &&
              runtimeType == other.runtimeType &&
              amount == other.amount &&
              betType == other.betType &&
              group == other.group &&
              occurFreq == other.occurFreq &&
              expiry == other.expiry;

  @override
  String toString() {
    return 'Bet(Amount: $amount, Bet Type: $betType, Group: $group, '
    + 'Freq of Occur: $occurFreq, Expiry: $expiry)';
  }
}