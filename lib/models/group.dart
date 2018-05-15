import 'package:meta/meta.dart';

@immutable
class Group {
  final String name;
  final List<String> members;
  final int groupAtStake;
  final String owner;
  // thumbnail picture
  // number of members

  Group({
    this.name,
    this.members,
    this.groupAtStake,
    this.owner,
  });

  Group copyWith({
    String name,
    List<String> members,
    int groupAtStake,
    String owner,
  }) {
    return Group(
      name: name ?? this.name,
      members: members ?? this.members,
      groupAtStake: groupAtStake ?? this.groupAtStake,
      owner: owner ?? this.owner,
    );
  }

  @override
  int get hashCode =>
      name.hashCode ^
      members.hashCode ^
      groupAtStake.hashCode ^
      owner.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
          other is Group &&
              runtimeType == other.runtimeType &&
              name == other.name &&
              members == other.members &&
              groupAtStake == other.groupAtStake &&
              owner == other.owner;

  @override
  String toString() {
    return 'Bet(Name: $name, Members: $members, Group At Stake: $groupAtStake, '
        + 'Owner: $owner)';
  }
}