import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';

class FirestoreService {
  static final FirestoreService _firestoreService = FirestoreService._internal();
  FirebaseFirestore db = FirebaseFirestore.instance;
  FirestoreService._internal();

  //final FirebaseFirestore db = FirebaseFirestore.instance;


  factory FirestoreService() {
    return _firestoreService;
  }

}