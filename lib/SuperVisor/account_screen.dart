import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../constants.dart';
import '../providers/auth.dart';

import '../utilities/listtile.dart';

class AccountScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    if (Provider.of<Auth>(context, listen: false).role == 'Supervisor') {
      return FutureBuilder(
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
                    child: Column(
                      // mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        SizedBox(
                          height: 70,
                        ),
                        Container(
                          width: double.infinity,
                          padding: EdgeInsets.all(10),
                          child: Card(
                            color: kBackgroundColor,
                            elevation: 4,
                            child: Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: Column(
                                children: <Widget>[
                                  AccountListTile(
                                    titleText: 'Log Out',
                                    icon: Icons.exit_to_app,
                                    actionType: 'logout',
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              });
            }
          }
        },
      );
    }
  }
}
