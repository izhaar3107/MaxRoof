import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../loginandsplash/login_screen.dart';
import '../constants.dart';

import 'account_screen.dart';
import '../providers/auth.dart';

class marketer extends StatefulWidget {
  @override
  _TabsScreenState createState() => _TabsScreenState();
}

class _TabsScreenState extends State<marketer> {
  List<Widget> _pages = [
    LoginScreen(),
    LoginScreen(),
  ];
  var _isInit = true;
  var _isLoading = false;

  int _selectedPageIndex = 0;
  bool _isSearching = false;
  final searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    // Provider.of<Auth>(context).tryAutoLogin().then((_) {});
  }

  @override
  void didChangeDependencies() {
    if (_isInit) {
      setState(() {
        _isLoading = true;
      });

      final _isAuth = Provider.of<Auth>(context, listen: false).isAuth;

      if (_isAuth) {
        _pages = [
          AccountScreen(),
        ];
      }
    }
    _isInit = false;
    super.didChangeDependencies();
  }

  void _handleSubmitted(String value) {
    final searchText = searchController.text;
    if (searchText.isEmpty) {
      return;
    }

    searchController.clear();

    // print(searchText);
  }

  void _selectPage(int index) {
    setState(() {
      _selectedPageIndex = index;
    });
  }

  void _showFilterModal(BuildContext ctx) {
    showModalBottomSheet(
      context: ctx,
      isScrollControlled: true,
      builder: (_) {},
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Marketer"),
        backgroundColor: Colors.lightBlue,
        actions: <Widget>[
          IconButton(
              icon: Icon(
                Icons.search,
                color: kSecondaryColor,
              ),
              onPressed: () {
                setState(() {
                  _isSearching = !_isSearching;
                });
              }),
        ],
      ),
      drawer: Drawer(
        child: ListView(
          children: <Widget>[
            FutureBuilder(
              builder: (ctx, dataSnapshot) {
                if (dataSnapshot.connectionState == ConnectionState.waiting) {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                } else {
                  if (dataSnapshot.error != null) {
                    //error
                    return Center(
                      child: Text('Error Occured'),
                    );
                  } else {
                    return Consumer<Auth>(builder: (context, authData, child) {
                      final user = authData.user;
                      return SingleChildScrollView(
                        child: Container(
                          width: double.infinity,
                          child: UserAccountsDrawerHeader(
                            accountEmail: Text(""),
                            currentAccountPicture: CircleAvatar(
                              backgroundColor: Theme.of(context).platform ==
                                      TargetPlatform.iOS
                                  ? Colors.blue
                                  : Colors.white,
                              child: CircleAvatar(
                                radius: 50,
                              ),
                            ),
                          ),
                        ),
                      );
                    });
                  }
                }
              },
            ),
            ListTile(
                title: Text("Profile"),
                trailing: Icon(Icons.arrow_forward),
                onTap: () {
                  AccountScreen();
                }),
            ListTile(
              title: Text("Attendance"),
              trailing: Icon(Icons.arrow_forward),
            ),
            ListTile(
              title: Text("Advance"),
              trailing: Icon(Icons.arrow_forward),
            ),
            ListTile(
              title: Text("Downloads"),
              trailing: Icon(Icons.arrow_forward),
            ),
            ListTile(
              title: Text("Logout"),
              trailing: Icon(Icons.arrow_forward),
            ),
          ],
        ),
      ),
      body: _pages[_selectedPageIndex],
      floatingActionButton: FloatingActionButton(
        onPressed: () => _showFilterModal(context),
        child: Icon(Icons.filter_list),
        backgroundColor: kDarkButtonBg,
      ),
    );
  }
}
