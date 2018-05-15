import 'package:flutter/material.dart';
import 'package:selfbet/models/models.dart';


class ExtraActionsButton extends StatelessWidget {
  final PopupMenuItemSelected<ExtraActions> onSelected;

  ExtraActionsButton({
    this.onSelected,
  });

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton<ExtraActions>(
      onSelected: onSelected,
      itemBuilder: (BuildContext context) => <PopupMenuItem<ExtraActions>>[
        const PopupMenuItem<ExtraActions>(
          value: ExtraActions.LogOut,
          child: Text("Logout"),
        ),
      ],
    );
  }
}
