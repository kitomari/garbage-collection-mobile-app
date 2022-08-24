import 'package:collection_app/screens/home_screen/client_screen.dart';
import 'package:collection_app/screens/home_screen/history_screen.dart';
import 'package:collection_app/screens/home_screen/home.dart';
import 'package:collection_app/screens/home_screen/profile_screen.dart';
import 'package:flutter/material.dart';

class BottomBar extends StatefulWidget {
  const BottomBar({ Key? key }) : super(key: key);

  @override
  State<BottomBar> createState() => _BottomBarState();
}

class _BottomBarState extends State<BottomBar> {
  int _page = 0;

  List<Widget> pages = [
    HomeScreen(),
    const ClientScreen(),
    const HistoryScreen(),
    ProfileScreen()
  ];

  void updatePage(int page){
    setState(() {
      _page = page;
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: pages[_page],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _page,
        selectedItemColor: Colors.blueAccent,
        unselectedItemColor: Colors.black,
        onTap: updatePage,
        items: [
          BottomNavigationBarItem(
            icon: Container(
              decoration: BoxDecoration(
                border: Border(
                  top: BorderSide(
                    color: _page == 0 ? Colors.blueAccent : Colors.black
                  )
                )
              ),
              child: const Icon(Icons.home_outlined),
            ),
            label: "Home",
          ),
          BottomNavigationBarItem(
            icon: Container(
              decoration: BoxDecoration(
                border: Border(
                  top: BorderSide(
                    color: _page == 1 ? Colors.blueAccent : Colors.black
                  )
                )
              ),
              child: const Icon(Icons.person_add),
            ),
            label: "Clients",
          ),
          BottomNavigationBarItem(
            icon: Container(
              decoration: BoxDecoration(
                border: Border(
                  top: BorderSide(
                    color: _page == 2 ? Colors.blueAccent : Colors.black
                  )
                )
              ),
              child: const Icon(Icons.history),
            ),
            label: "History",
          ),
          BottomNavigationBarItem(
            icon: Container(
              decoration: BoxDecoration(
                border: Border(
                  top: BorderSide(
                    color: _page == 3 ? Colors.blueAccent : Colors.black
                  )
                )
              ),
              child: const Icon(Icons.person),
            ),
            label: "Profile",
          ),
        ]
      ),
    );
  }
}