import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:kisaan_garh/global_variable/global_varialble.dart';
import 'package:kisaan_garh/helping_widgets/screen_navigation/screen_navigation.dart';
import 'package:kisaan_garh/models/post_model/seller_post_model.dart';
import 'package:kisaan_garh/screens/dashboard/home_screen/home_screen.dart';
import 'package:random_string/random_string.dart';

class SellerPostScreen extends StatefulWidget {
  final String docId;
  final String userType;

  SellerPostScreen({Key? key, required this.docId,required this.userType}) : super(key: key);

  @override
  State<SellerPostScreen> createState() => _SellerPostScreenState();
}

class _SellerPostScreenState extends State<SellerPostScreen> {
  final _productController = TextEditingController();
  final _descController = TextEditingController();
  final _priceController = TextEditingController();
  File? pickedFile;
  bool isButtonPressed = false;
  String? selectedValue;

  UploadSellerPost({required File pickFile}) async {
    setState(() {
      isButtonPressed = true;
    });
    final randomKey = randomAlphaNumeric(22);
    DocumentSnapshot userDocs =
        await firebaseFirestore.collection("users").doc(widget.docId).get();
    String downloadUrl = await uploadToStorage(pickFile, randomKey);
    print("this is upload task url =>>>>. $downloadUrl");
    SellerPostModel postModel = SellerPostModel(
        postType: "Seller",
        publishedDate: DateTime.now(),
        productImage: downloadUrl,
        uid: firebaseAuth.currentUser!.uid,
        docId: randomKey,
        username: (userDocs.data() as dynamic)["name"],
        price: _priceController.text,
        productDescription: _descController.text,
        productName: _productController.text, userType: widget.userType);

    await firebaseFirestore
        .collection("seller_post")
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

  void pickImage() async {
    final pickImage =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickImage != null) {
      print("your image is selected");
      setState(() {
        pickedFile = File(pickImage.path);
      });
      print("this is filepath =>>>$pickedFile");
    } else {
      print("Sorry there was an error");
    }
  }

  // upload To firebase storage
  Future<String> uploadToStorage(File image, String id) async {
    Reference ref = firebaseStorage.ref().child("usersPost").child(id);
    UploadTask uploadTask = ref.putFile(image);
    TaskSnapshot snap = await uploadTask;
    String downloadUrl = await snap.ref.getDownloadURL();
    /* print("-------Upload To Storage Run Hony Laga-------");
      String download = await uploadToStorage(pickedFile);
      setState(() {
        downloadUrl = download;
      });
      print("successfully run =>>>> $downloadUrl");*/
    return downloadUrl;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.orange,
        elevation: 0,
        centerTitle: true,
        title: Text(
          "Seller Post",
          style: Theme.of(context)
              .textTheme
              .headline3!
              .copyWith(color: Colors.white),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                GestureDetector(
                  onTap: () {
                    pickImage();
                  },
                  child: Card(
                    elevation: 10,
                    shadowColor: Colors.amber.shade200,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: pickedFile == null
                        ? Container(
                            height: 200,
                            width: 300,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15),
                            ),
                            child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    "Select an Image",
                                    style: Theme.of(context)
                                        .textTheme
                                        .headline3!
                                        .copyWith(
                                            color: Colors.grey,
                                            fontWeight: FontWeight.w500),
                                  ),
                                  Icon(
                                    Icons.broken_image_outlined,
                                    size: 60,
                                    color: Colors.orange,
                                  )
                                ]),
                          )
                        : Container(
                            height: 200,
                            width: 300,
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(15),
                              child: Image.file(
                                pickedFile ?? File(''),
                                height: 100,
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 20,
            ),
            // DropdownButton<String>(
            //   value: selectedValue,
            //   icon: Icon(Icons.add_shopping_cart),
            //   hint: Text(
            //     "Select Category",
            //     style: Theme.of(context).textTheme.headline4,
            //   ),
            //   items: <String>['Vegetable', 'Fruit', 'Wheat', 'Rice', 'Other']
            //       .map((String value) {
            //     return DropdownMenuItem<String>(
            //       value: value,
            //       child: Text(value),
            //       onTap: () {},
            //     );
            //   }).toList(),
            //   onChanged: (value) {
            //     setState(() {
            //       selectedValue = value;
            //     });
            //   },
            // ),
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
              height: 10,
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
                    controller: _productController,
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
                    controller: _descController,
                    style: Theme.of(context)
                        .textTheme
                        .headline4!
                        .copyWith(fontWeight: FontWeight.w500),
                    decoration: InputDecoration(
                        hintText: "Tell about your abouts",
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
                        hintText: "1Kg",
                        hintStyle: Theme.of(context)
                            .textTheme
                            .headline6!
                            .copyWith(
                                color: Colors.grey,
                                fontWeight: FontWeight.w500),
                        labelText: "Price",
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
                if (_descController.text.isNotEmpty ||
                    _priceController.text.isNotEmpty ||
                    _productController.text.isNotEmpty ||
                    pickedFile != null) {
                  UploadSellerPost(pickFile: pickedFile ?? File(''));
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
          ],
        ),
      ),
    );
  }
}
