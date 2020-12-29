import 'package:erp/SuperVisor/dashboard.dart';
import 'package:erp/SuperVisor/projectlist.dart';
import 'package:erp/SuperVisor/advance.dart';
import 'package:erp/loginandsplash/auth_screen.dart';
import 'package:erp/main.dart';
import 'package:erp/providers/auth.dart';
import 'package:provider/provider.dart';

import 'package:flutter/material.dart';

class DrawerItem {
  String title;
  IconData icon;
  DrawerItem(this.title, this.icon);
}

class Supervisor extends StatefulWidget {
  final drawerItems = [
    new DrawerItem("Profile", Icons.rss_feed),
    new DrawerItem("Attendance", Icons.local_pizza),
    new DrawerItem("Advance", Icons.info),
    new DrawerItem("Logout", Icons.info)
  ];

  @override
  State<StatefulWidget> createState() {
    return new HomePageState();
  }
}

class HomePageState extends State<Supervisor> {
  int _selectedDrawerIndex = 0;

  _getDrawerItemWidget(int pos) {
    switch (pos) {
      case 0:
        return new dashboard();
      case 1:
        return new projectlist();
      case 2:
        return new advance();
      case 3:
        return Provider.of<Auth>(context, listen: false)
            .logout()
            .then((_) => main());
      default:
        return new Text("Error");
    }
  }

  _onSelectItem(int index) {
    setState(() => _selectedDrawerIndex = index);
    Navigator.of(context).pop(); // close the drawer
  }

  @override
  Widget build(BuildContext context) {
    var drawerOptions = <Widget>[];
    for (var i = 0; i < widget.drawerItems.length; i++) {
      var d = widget.drawerItems[i];
      drawerOptions.add(new ListTile(
        leading: new Icon(d.icon),
        title: new Text(d.title),
        selected: i == _selectedDrawerIndex,
        onTap: () => _onSelectItem(i),
      ));
    }

    return new Scaffold(
      appBar: new AppBar(
        // here we display the title corresponding to the fragment
        // you can instead choose to have a static title
        title: new Text(widget.drawerItems[_selectedDrawerIndex].title),
      ),
      drawer: new Drawer(
        child: new Column(
          children: <Widget>[
            new UserAccountsDrawerHeader(
                accountName: new Text(
                    Provider.of<Auth>(context, listen: false).Employee),
                currentAccountPicture: Image.network(
                    'http://maxroof.theiis.com' +
                        Provider.of<Auth>(context, listen: false).profilePic),
                accountEmail:
                    Text(Provider.of<Auth>(context, listen: false).role)),
            new Column(children: drawerOptions)
          ],
        ),
      ),
      body: _getDrawerItemWidget(_selectedDrawerIndex),
    );
  }
}
