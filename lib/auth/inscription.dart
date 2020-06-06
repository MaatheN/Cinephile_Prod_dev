import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'authentification.dart';

class Inscription extends StatefulWidget {
  final Function toggleView;
  Inscription({ this.toggleView });

  _InscriptionState createState() => _InscriptionState();
}

class _InscriptionState extends State<Inscription> {

  final AuthService _auth = AuthService();
  final _formKey = GlobalKey<FormState>();
  String error = '';

  // text field state
  String email = '';
  String password = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //backgroundColor: Colors.brown[100],
      appBar: AppBar(
        //backgroundColor: Colors.brown[400],
        elevation: 0.0,
        title: Text('Rejoindre LeCinePhil'),
        /*actions: <Widget>[
          FlatButton.icon(
            icon: Icon(Icons.home),
            label: Text('Inscription'),
            onPressed: () => Navigator.pop(context),
          ),
        ],*/
      ),
      body: Container(
        padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 50.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: <Widget>[
              SizedBox(height: 20.0),
              TextFormField(
                validator: (val) => val.isEmpty ? 'Mail' : null,
                onChanged: (val) {
                  setState(() => email = val);
                },
              ),
              SizedBox(height: 20.0),
              TextFormField(
                obscureText: true,
                validator: (val) => val.length < 6 ? '+6 charactères Mote de Passe' : null,
                onChanged: (val) {
                  setState(() => password = val);
                },
              ),
              SizedBox(height: 20.0),
              RaisedButton(
                  color: Colors.pink[400],
                  child: Text(
                    'S\'inscrire',
                    style: TextStyle(color: Colors.white),
                  ),
                  onPressed: () async {
                    if(_formKey.currentState.validate()){
                      dynamic result = await _auth.registerWithEmailAndPassword(email, password);
                      if(result == null) {
                        setState(() {
                          error = 'Email non valide';
                        });
                      }
                    }
                  }
              ),
              SizedBox(height: 12.0),
              Text(
                error,
                style: TextStyle(color: Colors.red, fontSize: 14.0),
              )
            ],
          ),
        ),
      ),
    );
  }
}