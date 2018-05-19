class UserEntity {
  final String name;
  final int balance;
  final int atStake;
  final List<dynamic> groupNames;

  UserEntity(this.name, this.balance, this.atStake, this.groupNames);

  @override
  int get hashCode =>
      name.hashCode ^
      balance.hashCode ^
      atStake.hashCode ^
      groupNames.hashCode;

  @override
  bool operator ==(other) =>
      identical(this, other) ||
      other is UserEntity &&
          runtimeType == other.runtimeType &&
          name == other.name &&
          balance == other.balance &&
          atStake == other.atStake &&
          groupNames == other.groupNames;


  Map<String, Object> toJson() {
    return {
      "name": name,
      "balance": balance,
      "atStake": atStake,
      "groupNames": groupNames,
    };
  }

  @override
  String toString() {
    return 'UserEntity{name: $name, balance: $balance, atStake: $atStake, '
        'groupNames: $groupNames}';
  }

  static UserEntity fromJason(Map<String, Object> json) {
    return UserEntity(
      json["name"],
      json["balance"],
      json["atStake"],
      json["groupNames"],
    );
  }
}