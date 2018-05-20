class UserEntity {
  final String name;
  final int balance;
  final int atStake;

  UserEntity(this.name, this.balance, this.atStake);

  @override
  int get hashCode =>
      name.hashCode ^
      balance.hashCode ^
      atStake.hashCode;

  @override
  bool operator ==(other) =>
      identical(this, other) ||
      other is UserEntity &&
          runtimeType == other.runtimeType &&
          name == other.name &&
          balance == other.balance &&
          atStake == other.atStake;


  Map<String, Object> toJson() {
    return {
      "name": name,
      "balance": balance,
      "atStake": atStake,
    };
  }

  @override
  String toString() {
    return 'UserEntity{name: $name, balance: $balance, atStake: $atStake}';
  }

  static UserEntity fromJason(Map<String, Object> json) {
    return UserEntity(
      json["name"],
      json["balance"],
      json["atStake"],
    );
  }
}