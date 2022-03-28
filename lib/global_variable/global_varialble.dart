import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:kisaan_garh/screens/dashboard/home_screen/home_screen.dart';
import 'package:kisaan_garh/screens/dashboard/profile_screen/profile_screen.dart';

var firebaseFirestore = FirebaseFirestore.instance;
var firebaseAuth = FirebaseAuth.instance;
var firebaseStorage = FirebaseStorage.instance;
var docId;
