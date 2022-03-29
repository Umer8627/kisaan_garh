import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:kisaan_garh/models/post_model/buyer_post_model.dart';
import 'package:random_string/random_string.dart';

import '../../../global_variable/global_varialble.dart';
import '../../../helping_widgets/screen_navigation/screen_navigation.dart';
import '../home_screen/home_screen.dart';

class BuyerPostScreen extends StatefulWidget {
  final String docId;
  final String userType;
  const BuyerPostScreen({Key? key,required this.docId,required this.userType}) : super(key: key);

  @override
  _BuyerPostScreenState createState() => _BuyerPostScreenState();
}

class _BuyerPostScreenState extends State<BuyerPostScreen> {

  final _productNameController= TextEditingController();
  final _quanityController= TextEditingController();
  final _descriptionController = TextEditingController();
  final _priceController = TextEditingController();
  String? selectedValue;
  bool isButtonPressed = false;

  UploadBuyerPost() async {
    setState(() {
      isButtonPressed = true;
    });
    final randomKey = randomAlphaNumeric(22);
    DocumentSnapshot userDocs =
    await firebaseFirestore.collection("users").doc(widget.docId).get();

    BuyerPostModel postModel = BuyerPostModel(
      postType: "Buyer",
        publishedDate: DateTime.now(),
        uid: firebaseAuth.currentUser!.uid,
        docId: randomKey,
        username: (userDocs.data() as dynamic)["name"],
        averagePrice: _priceController.text,
        description: _descriptionController.text,
        productName: _productNameController.text, userType: widget.userType, quantity: _quanityController.text);

    await firebaseFirestore
        .collection("buyer_post")
        .doc(randomKey)
        .set(postModel.toJson());

    setState(() {
      isButtonPressed = false;
    });
    changeScreenReplace(
        context,
        HomeScreen(
          docId: widget.docId,
          userType: widget.userType,
        ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.orange,
        elevation: 0,
        centerTitle: true,
        title: Text(
          "Buyer Post",
          style: Theme.of(context)
              .textTheme
              .headline3!
              .copyWith(color: Colors.white),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(children: [
          SizedBox(
            height: 20,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: Card(
              elevation: 7,
              margin: EdgeInsets.zero,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              child: Padding(
                padding: const EdgeInsets.only(left: 25, right: 20),
                child: DropdownButton(
                  elevation: 4,
                  isExpanded: true,
                  dropdownColor: Colors.grey.shade50,
                  icon: Icon(Icons.arrow_drop_down_circle_outlined),
                  iconEnabledColor: Colors.orange,
                  underline: Container(),
                  hint: Row(
                    children: [
                      Icon(Icons.add_shopping_cart_outlined,color: Colors.orange,),
                      SizedBox(
                        width: 10,
                      ),
                      Text(
                        "Select Category",
                        style: Theme.of(context)
                            .textTheme
                            .headline4!
                            .copyWith(fontWeight: FontWeight.w500,color: Colors.orange),
                      ),
                    ],
                  ),
                  value: selectedValue,
                  items: <String>[
                    'Vegetable',
                    'Fruit',
                    'Wheat',
                    'Rice',
                    'Other'
                  ].map((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                      onTap: () {},
                    );
                  }).toList(),
                  onChanged: (newVal) {
                    setState(() {
                      selectedValue = newVal.toString();
                    });
                  },
                ),
              ),
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: Card(
              elevation: 10,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15)),
              shadowColor: Colors.amber.shade200,
              child: Padding(
                padding: const EdgeInsets.only(left: 8.0),
                child: TextFormField(
                  cursorColor: Colors.orange,
                  controller: _productNameController,
                  style: Theme.of(context)
                      .textTheme
                      .headline4!
                      .copyWith(fontWeight: FontWeight.w500),
                  decoration: InputDecoration(
                      hintText: "wheat,vegetable,fruits etc",
                      hintStyle: Theme.of(context)
                          .textTheme
                          .headline6!
                          .copyWith(
                          color: Colors.grey,
                          fontWeight: FontWeight.w500),
                      labelText: "Product",
                      labelStyle: Theme.of(context)
                          .textTheme
                          .headline4!
                          .copyWith(
                          color: Colors.orange,
                          fontWeight: FontWeight.w500),
                      border: InputBorder.none),
                ),
              ),
            ),
          ),

          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: Card(
              elevation: 10,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15)),
              shadowColor: Colors.amber.shade200,
              child: Padding(
                padding: const EdgeInsets.only(left: 8.0),
                child: TextFormField(
                  cursorColor: Colors.orange,
                  controller: _quanityController,
                  style: Theme.of(context)
                      .textTheme
                      .headline4!
                      .copyWith(fontWeight: FontWeight.w500),
                  decoration: InputDecoration(
                      hintText: "1Kg,2kg,40kg",
                      hintStyle: Theme.of(context)
                          .textTheme
                          .headline6!
                          .copyWith(
                          color: Colors.grey,
                          fontWeight: FontWeight.w500),
                      labelText: "Quantity",
                      labelStyle: Theme.of(context)
                          .textTheme
                          .headline4!
                          .copyWith(
                          color: Colors.orange,
                          fontWeight: FontWeight.w500),
                      border: InputBorder.none),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: Card(
              elevation: 10,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15)),
              shadowColor: Colors.amber.shade200,
              child: Padding(
                padding: const EdgeInsets.only(left: 8.0),
                child: TextFormField(
                  cursorColor: Colors.orange,
                  maxLines: 2,

                  controller: _descriptionController,
                  style: Theme.of(context)
                      .textTheme
                      .headline4!
                      .copyWith(fontWeight: FontWeight.w500),
                  decoration: InputDecoration(
                      hintText: "Write about your product",
                      hintStyle: Theme.of(context)
                          .textTheme
                          .headline6!
                          .copyWith(
                          color: Colors.grey,
                          fontWeight: FontWeight.w500),
                      labelText: "Description",
                      labelStyle: Theme.of(context)
                          .textTheme
                          .headline4!
                          .copyWith(
                          color: Colors.orange,
                          fontWeight: FontWeight.w500),
                      border: InputBorder.none),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: Card(
              elevation: 10,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15)),
              shadowColor: Colors.amber.shade200,
              child: Padding(
                padding: const EdgeInsets.only(left: 8.0),
                child: TextFormField(
                  cursorColor: Colors.orange,
                  controller: _priceController,
                  style: Theme.of(context)
                      .textTheme
                      .headline4!
                      .copyWith(fontWeight: FontWeight.w500),
                  decoration: InputDecoration(
                      hintText: "1Kg,40kg,Price",
                      hintStyle: Theme.of(context)
                          .textTheme
                          .headline6!
                          .copyWith(
                          color: Colors.grey,
                          fontWeight: FontWeight.w500),
                      labelText: "Average Price",
                      labelStyle: Theme.of(context)
                          .textTheme
                          .headline4!
                          .copyWith(
                          color: Colors.orange,
                          fontWeight: FontWeight.w500),
                      border: InputBorder.none),
                ),
              ),
            ),
          ),

          SizedBox(
            height: 20,
          ),
          InkWell(
            onTap: () async {
              if (_descriptionController.text.isNotEmpty ||
                  _priceController.text.isNotEmpty ||
                  _productNameController.text.isNotEmpty ||
                  _priceController.text.isNotEmpty) {
                UploadBuyerPost();
              } else {
                print("you are not good to go");
              }
            },
            child: isButtonPressed
                ? Container(
              width: 150,
              height: 43,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                  color: Colors.orange.shade400,
                  borderRadius: BorderRadius.circular(15)),
              child: Center(
                child: CircularProgressIndicator(
                  color: Colors.white,
                ),
              ),
            )
                : Container(
              width: 150,
              height: 43,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                  color: Colors.orange.shade400,
                  borderRadius: BorderRadius.circular(15)),
              child: Text(
                "Post",
                style: Theme.of(context)
                    .textTheme
                    .headline3!
                    .copyWith(color: Colors.white),
              ),
            ),
          ),
        ],),
      ),
    );
  }
}
