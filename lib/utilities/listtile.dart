import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../constants.dart';
import '../providers/auth.dart';

class AccountListTile extends StatelessWidget {
  final String titleText;
  final IconData icon;
  final String actionType;

  AccountListTile({
    @required this.titleText,
    @required this.icon,
    @required this.actionType,
  });

  void _actionHandler(BuildContext context) {
    if (actionType == 'logout') {
      Provider.of<Auth>(context, listen: false).logout().then((_) =>
          Navigator.pushNamedAndRemoveUntil(
              context, '/supervisor', (r) => false));
    } else if (actionType == 'edit') {
    } else if (actionType == 'change_password') {}
  }

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: CircleAvatar(
        backgroundColor: kLightBlueColor,
        radius: 20,
        child: Padding(
          padding: EdgeInsets.all(6),
          child: FittedBox(
            child: Icon(icon),
          ),
        ),
      ),
      trailing: IconButton(
        icon: Icon(Icons.arrow_forward_ios),
        onPressed: () => _actionHandler(context),
        color: Colors.grey,
      ),
    );
  }
}
