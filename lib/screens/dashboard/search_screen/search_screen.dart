import 'package:flutter/material.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({Key? key, this.docId}) : super(key: key);
  final String? docId;
  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.orange,
        elevation: 0,
        centerTitle: true,
        title: Text(
          "Search Items",
          style: Theme.of(context)
              .textTheme
              .headline3!
              .copyWith(color: Colors.white),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.all(12),
        child: Column(children: [
          Card(
            elevation: 7,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            shadowColor: Colors.orange.shade200,
            child: Padding(
              padding: EdgeInsets.only(left: 12),
              child: TextField(
                cursorColor: Colors.deepOrange,
                decoration: InputDecoration(
                  contentPadding: EdgeInsets.all(15),
                  hintText: "Search anything",
                  border: InputBorder.none,
                  suffixIcon: Icon(
                    Icons.search,
                    color: Colors.grey,
                  ),
                ),
              ),
            ),
          ),
        ]),
      ),
    );
  }
}
