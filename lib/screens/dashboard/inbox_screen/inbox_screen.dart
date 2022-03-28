import 'package:flutter/material.dart';

class InboxScreen extends StatefulWidget {
  const InboxScreen({Key? key, this.docId}) : super(key: key);
  final String? docId;
  @override
  State<InboxScreen> createState() => _InboxScreenState();
}

class _InboxScreenState extends State<InboxScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.orange,
        elevation: 0,
        centerTitle: true,
        title: Text(
          "Inbox",
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
                  hintText: "Search User",
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
