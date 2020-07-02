import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class DatabaseService {
  final String uid;
  DatabaseService({this.uid});
  final CollectionReference brewCollection = Firestore.instance.collection('brew');

  Future updateuserData(String sugars,String name,int strength)async{
    return await brewCollection.document(uid).setData({
      'sugars':sugars,
      'name':name,
      'strength':strength,
    });
  }
  //get brew streams
  Stream<QuerySnapshot>get brews{
    return brewCollection.snapshots();
  }
}