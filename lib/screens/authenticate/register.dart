import 'package:flutter/material.dart';
import 'package:flutterfirebase/services/auth.dart';
import 'package:flutterfirebase/shared/constants.dart';
import 'package:flutterfirebase/shared/loading.dart';

class Register extends StatefulWidget {

  final Function toggleView;
  Register({this.toggleView});

  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {

  final AuthService _auth = AuthService();
  final _formKey=GlobalKey<FormState>();
  String email='';
  String password='';
  String error='';
  bool loading=false;

  @override
  Widget build(BuildContext context) {
    return loading ? Loading(): Scaffold(
      backgroundColor: Colors.brown[100],
      appBar: AppBar(
          backgroundColor: Colors.brown[900],
          elevation:0,
          title:Text('Sign up'),
        actions: <Widget>[
          FlatButton.icon(
            icon:Icon(Icons.person),
            label:Text('Sign in'),
            onPressed: (){
              widget.toggleView();
            },
          )
        ],
      ),
      body:SingleChildScrollView(
        child: Container(
          padding:EdgeInsets.symmetric(vertical: 20,horizontal: 50),
          child:Form(
            key: _formKey,
            child:Column(
              children: <Widget>[
                SizedBox(height:100),
                TextFormField(
                  decoration:textInputDeco.copyWith(hintText: 'Email'),
                  validator: (val)=>val.isEmpty ? 'Enter an email':null,
                  onChanged: (val){
                    setState(() {
                      email=val;
                    });
                  },

                ),
                SizedBox(height:20),
                TextFormField(
                  decoration:textInputDeco.copyWith(hintText: 'Password'),
                  validator: (val)=>val.length<6 ? 'Password must have more than 6 chars ':null,
                  obscureText: true,
                  onChanged: (val){
                    setState(() {
                      password=val;
                    });
                  },
                ),
                SizedBox(height:30),
                RaisedButton(
                  color:Colors.pink[400],
                  child:Text(
                    'Sign up',
                    style:TextStyle(color:Colors.white),
                  ),
                  onPressed: ()async{
                  if(_formKey.currentState.validate()){
                    setState(() {
                      loading=true;
                    });
                   dynamic result = await _auth.registerEmailPassword(email, password);
                   if(result==null){
                     print('empty');
                      setState(() {
                        loading=false;
                        error='Please supply correct details';
                      });
                   }
                  }
                  },
                ),
                SizedBox(height:10),
                Text(
                    error,
                  style:TextStyle(color:Colors.red, fontSize: 14)
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
