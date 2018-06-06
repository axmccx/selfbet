import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:intl/intl.dart';
import 'package:selfbet/models/models.dart';

class GroupDisplayScreen extends StatelessWidget {
  final Group group;
  final List<UserEntity> members;

  GroupDisplayScreen({
    @required this.group,
    @required this.members,
  });

  @override
  Widget build(BuildContext context) {
    double atStakeDouble = group.groupAtStake / 100;
    return Scaffold(
      appBar: AppBar(
        title: Text("${group.name}"),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            margin: EdgeInsets.fromLTRB(30.0, 30.0, 15.0, 10.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  "Group Name: ${group.name}",
                  style: TextStyle(
                    fontSize: 24.0,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                Padding(padding: EdgeInsets.all(10.0)),
                Text(
                  "Stake in Group: \$${atStakeDouble.toStringAsFixed(2)}",
                  style: TextStyle(
                    fontSize: 24.0,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                Padding(padding: EdgeInsets.all(10.0)),
                Row(
                  children: <Widget>[
                    Text("Members"),
                    Expanded(
                      child: Container(),
                    ),
                    Text("At Stake"),
                  ],
                ),

              ],
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemBuilder: (BuildContext context, int index) {
                DateTime joinDate = DateTime.fromMillisecondsSinceEpoch(
                    group.members[members[index].uid]
                );
                return _UserRow(
                    user: members[index],
                    joinDate: joinDate,
                    atStakeInGroup: group.membersAtStake[members[index].uid],
                );
              },
              itemCount: members.length,
            ),
          ),
        ],
      ),
    );
  }
}

class _UserRow extends StatelessWidget {
  final UserEntity user;
  final DateTime joinDate;
  final int atStakeInGroup;

  const _UserRow({
    @required this.user,
    @required this.joinDate,
    @required this.atStakeInGroup,
  });

  @override
  Widget build(BuildContext context) {
    double atStakeDouble = atStakeInGroup / 100;
    return Column(
      children: <Widget>[
        ListTile(
          leading: CircleAvatar(
              child: Text(user.name[0]),
          ),
          title: Row(
            children: <Widget>[
              Text(user.name),
              Expanded(
                child: Container(),
              ),
              Text("\$${atStakeDouble.toStringAsFixed(2)}"),
            ],
          ),
          subtitle: Text("Joined: ${DateFormat.yMMMMd().format(joinDate)}"),
        ),
        Divider(),
      ],
    );
  }
}
