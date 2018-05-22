import 'package:flutter/material.dart';
import 'package:selfbet/models/models.dart';


class GroupPopupMenu extends StatelessWidget {
  final PopupMenuItemSelected<ExtraActions> onSelected;
  final bool canChangeOwner;
  final bool canLeaveGroup;
  final bool canDeleteGroup;

  GroupPopupMenu({
    this.onSelected,
    this.canChangeOwner,
    this.canLeaveGroup,
    this.canDeleteGroup,
  });

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton<ExtraActions>(
      onSelected: onSelected,
      itemBuilder: (BuildContext context) => <PopupMenuItem<ExtraActions>>[
        PopupMenuItem<ExtraActions>(
          enabled: canChangeOwner,
          value: ExtraActions.ChangeGroupOwner,
          child: Text("Change Owner"),
        ),
        PopupMenuItem<ExtraActions>(
          enabled: canLeaveGroup,
          value: ExtraActions.LeaveGroup,
          child: Text("Leave Group"),
        ),
        PopupMenuItem<ExtraActions>(
          enabled: canDeleteGroup,
          value: ExtraActions.DeleteGroup,
          child: Text("Delete Group"),
        ),
      ],
    );
  }
}
