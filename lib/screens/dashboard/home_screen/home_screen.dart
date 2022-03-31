
import 'package:flutter/material.dart';
import 'package:kisaan_garh/screens/dashboard/home_screen/seller_screen/seller_screen.dart';

import 'buyer_screen/buyper_screen.dart';


class HomeScreen extends StatefulWidget {
  final String docId;
  final String userType;
  HomeScreen({Key? key,required this.userType,required this.docId}) : super(key: key);


  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with SingleTickerProviderStateMixin {
  TabController? _tabController;
  final List<Tab> topTabs = [
    Tab(
     text: "Seller",
    ),
    Tab(
     text: "Buyer",
    ),
  ];
  @override
  void initState() {
    _tabController = TabController(length: 2, initialIndex: 0, vsync: this)
      ..addListener(() {
        setState(() {});
      });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
            backgroundColor: Colors.orange,
            elevation: 0,
            title: Text(
              "Kisaan Garh",
              style: Theme.of(context)
                  .textTheme
                  .headline3!
                  .copyWith(color: Colors.white),
            ),
            centerTitle: true,
              bottom: TabBar(
                controller: _tabController,
                indicatorColor: Colors.white,
                tabs: topTabs,
              )
          ),

      body: TabBarView(
        controller: _tabController,
        children: [
          SellerList(
            userType: widget.userType,
            docId: widget.docId,
          ),
          BuyerList(
            docId: widget.docId,
            userType: widget.userType,
          ),

        ],
      ),

    );
  }

}
