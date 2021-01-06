import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'providers/projectlist.dart';
import 'widgets/leads_list.dart';

class leadslist extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: <Widget>[
          Container(
            width: double.infinity,
            padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text(
                  'Leads',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                ),
              ],
            ),
          ),
          FutureBuilder(
            future: Provider.of<leadsprovider>(context, listen: false)
                .fetchprescription(context),
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
                  return Consumer<leadsprovider>(
                    builder: (context, courseData, child) =>
                        StaggeredGridView.countBuilder(
                      padding: const EdgeInsets.all(10.0),
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      crossAxisCount: 1,
                      itemCount: courseData.items.length,
                      itemBuilder: (ctx, index) {
                        return leads_list(
                            //  course: courseData.items[index],
                            );
                        // return Text(myCourseData.items[index].title);
                      },
                      staggeredTileBuilder: (int index) => StaggeredTile.fit(1),
                      mainAxisSpacing: 10.0,
                      crossAxisSpacing: 10.0,
                    ),
                  );
                }
              }
            },
          ),
        ],
      ),
    );
  }
}
