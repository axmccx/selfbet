import 'package:meta/meta.dart';

@immutable
class Group {
  final String name;
  final Map<dynamic, dynamic> members;
  final Map<dynamic, dynamic> membersAtStake;
  final int groupAtStake;
  final String owner;

  Group({
    @required this.name,
    @required this.members,
    @required this.membersAtStake,
    @required this.groupAtStake,
    @required this.owner,
  });

  Group copyWith({
    String name,
    Map<dynamic, dynamic> members,
    Map<dynamic, dynamic> membersAtStake,
    int groupAtStake,
    String owner,
  }) {
    return Group(
      name: name ?? this.name,
      members: members ?? this.members,
      membersAtStake: membersAtStake ?? this.membersAtStake,
      groupAtStake: groupAtStake ?? this.groupAtStake,
      owner: owner ?? this.owner,
    );
  }

  @override
  int get hashCode =>
      name.hashCode ^
      members.hashCode ^
      membersAtStake.hashCode ^
      groupAtStake.hashCode ^
      owner.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
          other is Group &&
              runtimeType == other.runtimeType &&
              name == other.name &&
              members == other.members &&
              membersAtStake == other.membersAtStake &&
              groupAtStake == other.groupAtStake &&
              owner == other.owner;

  Map<String, Object> toJson() {
    return {
      "name" : name,
      "members": members,
      "membersAtStake": membersAtStake,
      "owner" : owner,
    };
  }

  @override
  String toString() {
    return 'Group{'
        'Name: $name, '
        'Members: $members, '
        'membersAtStake: $membersAtStake, '
        'Group At Stake: $groupAtStake, '
        'Owner: $owner, '
        '}';
  }
}