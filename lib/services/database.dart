import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutterfirebase/models/brew.dart';

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
  //brew list from snapshots
  List<Brew> _brewListFromSnapshot(QuerySnapshot snapshot){
    return snapshot.documents.map((doc){
      return Brew(
        name:doc.data['name'] ?? '',
        strength:doc.data['strength'] ?? '',
        sugars:doc.data['sugars'] ?? '0'
      );
    }).toList();
  }
  //get brew streams
  Stream<List<Brew>>get brews{
    return brewCollection.snapshots()
    .map(_brewListFromSnapshot);
  }
}