import 'package:selfbet/models/models.dart';

class InitAppAction {
  @override
  String toString() {
    return 'InitApp{}';
  }
}

class ConnectToDataSourceAction {
  @override
  String toString() {
    return 'ConnectToDataSource{}';
  }
}

class LoadDashboard {
  final int balance;
  final int atStake;

  LoadDashboard(this.balance, this.atStake);

  @override
  String toString() {
    return 'LoadDashboard{balance: $balance, atStake: $atStake}';
  }
}

class UpdateTabAction {
  final AppTab newTab;

  UpdateTabAction(this.newTab);

  @override
  String toString() {
    return 'UpdateTab{newTab: $newTab}';
  }
}

class CreditFaucet {
  @override
  String toString() {
    return 'CreditFaucet{}';
  }
}

class PlaceBet {
  @override
  String toString() {
    return 'Placebet{}';
  }
}

class DeleteBet {
  @override
  String toString() {
    return 'DeleteBet{}';
  }
}

class RenewBet {
  @override
  String toString() {
    return 'RenewBet{}';
  }
}

class JoinGroup {
  @override
  String toString() {
    return 'JoingGroup{}';
  }
}

class CreateGroup {
  @override
  String toString() {
    return 'CreateGroup{}';
  }
}

class LeaveGroup {
  @override
  String toString() {
    return 'LeaveGroup{}';
  }
}

class PlaceHolderAction{
  @override
  String toString() {
    return 'PlaceHolder{}';
  }
}
