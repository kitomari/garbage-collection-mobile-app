import 'package:collection_app/screens/tabs/all_scanned.dart';
import 'package:collection_app/screens/tabs/scanned_today.dart';
import 'package:flutter/material.dart';

class HistoryScreen extends StatelessWidget {
  const HistoryScreen({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(),
      backgroundColor: Colors.blueAccent,
      body: DefaultTabController(
              length: 2, 
              child: Scaffold(
                appBar: AppBar(
                  automaticallyImplyLeading: false,
                  title: Text('History'),
                  centerTitle: true,
                  bottom: TabBar(
                    tabs: [
                      Tab(text: 'Today',),
                      Tab(text: 'All',),
                    ]
                  ),
                ),
                body: TabBarView(
                  children: [
                    ScannedToday(),
                    AllScanned()
                  ]),
              )
            )
          // ],

        // ),
      // ),
    );
  }
}