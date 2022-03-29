import 'package:flutter/material.dart';
import 'package:kisaan_garh/helping_widgets/screen_navigation/screen_navigation.dart';
import 'package:kisaan_garh/screens/dashboard/add_post_screen/buyer_post_screen.dart';

import '../seller_add_post.dart';


class SelectPostScreen extends StatefulWidget {
  final String docId;
  final String userType;
  const SelectPostScreen({Key? key,required this.userType,required this.docId}) : super(key: key);

  @override
  State<SelectPostScreen> createState() => _SelectPostScreenState();
}

class _SelectPostScreenState extends State<SelectPostScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.orange,
        elevation: 0,
        centerTitle: true,
        title: Text(
          "Select Post",
          style: Theme.of(context)
              .textTheme
              .headline3!
              .copyWith(color: Colors.white),
        ),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,

        children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
      style: ElevatedButton.styleFrom(
      primary: Colors.orange, //background color of button
              side: BorderSide(width:3, color:Colors.orangeAccent), //border width and color
              elevation: 3, //elevation of button
              shape: RoundedRectangleBorder( //to set border radius to button
                  borderRadius: BorderRadius.circular(10)
              ),
              padding: EdgeInsets.only(left: 40,right: 40) //content padding inside button
      ),
                onPressed: (){
              changeScreen(context, SellerPostScreen(userType: widget.userType, docId: widget.docId,));
            }, child: Text("Are You a Seller")),
          ],
        ),
        SizedBox(
          height: 20,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
                style: ElevatedButton.styleFrom(
                    primary: Colors.orange, //background color of button
                    side: BorderSide(width:3, color:Colors.orangeAccent), //border width and color
                    elevation: 3, //elevation of button
                    shape: RoundedRectangleBorder( //to set border radius to button
                        borderRadius: BorderRadius.circular(10)
                    ),
                    padding: EdgeInsets.only(left: 40,right: 40) //content padding inside button
                ),
                onPressed: (){
              changeScreen(context, BuyerPostScreen(userType: widget.userType, docId: widget.docId,));
            }, child: Text("Are You a buyer")),
          ],
        ),
      ],),
    );
  }
}
