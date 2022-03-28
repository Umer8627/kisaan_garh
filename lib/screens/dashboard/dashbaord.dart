import 'package:flutter/material.dart';
import 'package:kisaan_garh/global_variable/global_varialble.dart';
import 'package:kisaan_garh/helping_widgets/custom_icon/custom_icon.dart';
import 'package:kisaan_garh/screens/dashboard/add_post_screen/add_post.dart';
import 'package:kisaan_garh/screens/dashboard/home_screen/home_screen.dart';
import 'package:kisaan_garh/screens/dashboard/inbox_screen/inbox_screen.dart';
import 'package:kisaan_garh/screens/dashboard/profile_screen/profile_screen.dart';
import 'package:kisaan_garh/screens/dashboard/search_screen/search_screen.dart';
import 'package:kisaan_garh/shared_pref/shared_pref.dart';

class Dashboard extends StatefulWidget {
  Dashboard({Key? key, required this.docId}) : super(key: key);
  final String docId;
  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  int pageIndex = 0;
  String? docId;

  @override
  Widget build(BuildContext context) {
    List<dynamic> pages = [
      HomeScreen(docId: widget.docId),
      SearchScreen(docId: widget.docId),
      AddPostScreen(
        docId: widget.docId,
      ),
      InboxScreen(docId: widget.docId),
      ProfileScreen(docId: widget.docId),
    ];
    return Scaffold(
        bottomNavigationBar: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          selectedItemColor: Colors.orange,
          unselectedItemColor: Colors.grey,
          backgroundColor: Colors.white,
          currentIndex: pageIndex,
          onTap: (index) {
            setState(() {
              pageIndex = index;
            });
          },
          items: [
            BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
            BottomNavigationBarItem(icon: Icon(Icons.search), label: 'Search'),
            BottomNavigationBarItem(icon: CustomIcon(), label: ''),
            BottomNavigationBarItem(
                icon: Icon(Icons.message), label: 'Message'),
            BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
          ],
        ),
        body: pages[pageIndex]);
  }
}
