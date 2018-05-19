import 'package:meta/meta.dart';

@immutable
class Group {
  final String name;
  final Map<String, bool> members;
  final int groupAtStake;
  final String owner;
  // thumbnail picture
  // number of members

  Group({
    @required this.name,
    @required this.members,
    @required this.groupAtStake,
    @required this.owner,
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

  Map<String, Object> toJson() {
    return {
      "name" : name,
      "members": members,
      "groupAtStake" : groupAtStake,
      "owner" : owner,
    };
  }

  @override
  String toString() {
    return 'Group{Name: $name, Members: $members, '
        'Group At Stake: $groupAtStake, Owner: $owner}';
  }
}