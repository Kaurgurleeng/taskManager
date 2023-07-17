import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

var dbInstance = FirebaseFirestore.instance;
var uid = FirebaseAuth.instance.currentUser!.uid;
var userRef = dbInstance.collection("users");
var postsRef = dbInstance.collection("posts");