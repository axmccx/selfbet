import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:selfbet/models/models.dart';
import 'package:selfbet/presentation/loading_indicator.dart';
import 'package:selfbet/presentation/group_tile.dart';
import 'package:selfbet/containers/containers.dart';


class GroupList extends StatelessWidget {
  final List<Group> groups;
  final Function showMembers;

  GroupList({
    @required this.groups,
    @required this.showMembers,
  });

  @override
  Widget build(BuildContext context) {
    return AppLoading(builder: (context, loading) {
      return Stack(
          children: <Widget>[
            _buildGridView(),
            Align(
              child: loading ? LoadingIndicator("Loading") : Container(),
              alignment: FractionalOffset.center,
            ),
          ],
      );
    });
  }

  GridView _buildGridView() {
    return GridView.builder(
      gridDelegate: new SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
      ),
      itemCount: groups.length,
      itemBuilder: (BuildContext context, int index) {
        final group = groups[index];
        return GroupTile(
          group: group,
          onTap: showMembers,
        );
      },
    );
  }
}
