import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutterfirebase/screens/home/brewList.dart';
import 'package:flutterfirebase/services/auth.dart';
import 'package:provider/provider.dart';
import 'package:flutterfirebase/services/database.dart';
import 'package:flutterfirebase/models/brew.dart';

class Home extends StatelessWidget {

  final AuthService _auth = AuthService();

  @override
  Widget build(BuildContext context) {
    return StreamProvider<List<Brew>>.value(
      value:DatabaseService().brews,
      child: Scaffold(
        backgroundColor: Colors.brown[100],
        appBar: AppBar(
          title:Text('Brew Crew'),
          backgroundColor: Colors.brown[900],
          elevation:0,
          actions: <Widget>[
            FlatButton.icon(
              icon:Icon(Icons.person),
              label:Text('logout'),
              onPressed: ()async{
                await _auth.signOut();
              },
            )
          ],
        ),
        body:BrewList(),
      ),
    );
  }
}
