import 'package:firebase_auth/firebase_auth.dart';
import '../movie_list.dart';
import 'inscription.dart';
import 'user.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Authentification extends StatefulWidget {
  @override
  AuthentificationPageState createState() {
    return new AuthentificationPageState();
  }
}
class AuthentificationPageState extends State<Authentification> {

  Color couleurPrincipale = const Color(0xff3C3261);
  final AuthService _auth = AuthService();
  final _formKey = GlobalKey<FormState>();
  String email = '';
  String password = '';
  String error = '';

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        elevation: 0.3,
        centerTitle: true,
        title: new Text('Le Cinéphil\'',
        style: new TextStyle(
          color: Colors.white,
          fontFamily: 'Arvo',
          fontWeight: FontWeight.bold,
        ),),
      ),
      body: Container(
        padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 50.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: <Widget>[
              SizedBox(height: 20.0),
              TextFormField(
                validator: (val) => val.isEmpty ? 'Enter an email' : null,
                onChanged: (val) {
                  setState(() => email = val);
                },
              ),
              SizedBox(height: 20.0),
              TextFormField(
                obscureText: true,
                validator: (val) => val.length < 6 ? 'Format du mot de passe invalide' : null,
                onChanged: (val) {
                  setState(() {
                    password = val;
                  });
                },
              ),
              SizedBox(height: 20.0),
              RaisedButton(
                //color: couleurPrincipale,
                child: Text(
                  'Connexion',
                  style: new TextStyle(
                    color: couleurPrincipale,
                    fontFamily: 'Alvo'
                  ),
                ),
                onPressed: () async {
                  if(_formKey.currentState.validate()){
                    dynamic result = await _auth.signInWithEmailAndPassword(email, password);
                    if(result == null) {
                      setState(() {
                        error = 'erreur, impossible de valider ces entrées';
                      });
                    }else{
                      Navigator.push(context, new MaterialPageRoute(builder: (context){
                        return new MovieList();
                      }));
                    }
                  }
                },
              ),
              SizedBox(height: 20.0),
              //new Inscription(),
              new Padding(padding: const EdgeInsets.all(16.0),
                child: RaisedButton.icon(
                  onPressed: () {
                    Navigator.push(context, new MaterialPageRoute(builder: (context){
                      return new Inscription();
                    }));
                  },
                    icon: Icon(
                      Icons.person_add,
                      color: couleurPrincipale,
                    ),
                    label: Text(
                      'Inscription',
                      style: new TextStyle(
                        color: couleurPrincipale,
                        fontFamily: 'Arvo'
                    ),
                  ),
                ),
              ),
              SizedBox(height: 20.0,),
              new Padding(padding: const EdgeInsets.all(16.0),
                child: RaisedButton.icon(
                  onPressed: () {
                    Navigator.push(context, new MaterialPageRoute(builder: (context) {
                      return new ResetMdp();
                    }));
                  },
                  label: Text('Mot de passe oublié',
                  style: new TextStyle(
                    color: couleurPrincipale,
                    fontFamily: 'Arvo'
                  ),
                ),
              ),)
            ],
          ),
        ),
      ),
    );
  }
}

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  User _userFromFirebaseUser(FirebaseUser user) {
    return user != null ? User(uid: user.uid) : null;
  }

  Stream<User> get user {
    return _auth.onAuthStateChanged
        .map(_userFromFirebaseUser);
  }

  Future signInWithEmailAndPassword(String email, String password) async {
    try {
      AuthResult result = await _auth.signInWithEmailAndPassword(email: email, password: password);
      FirebaseUser user = result.user;
      return user;
    } catch (error) {
      print(error.toString());
      return null;
    }
  }

  Future registerWithEmailAndPassword(String email, String password) async {
    try {
      AuthResult result = await _auth.createUserWithEmailAndPassword(email: email, password: password);
      FirebaseUser user = result.user;
      return  _userFromFirebaseUser(user);
    } catch (error) {
      print(error.toString());
      return null;
    }
  }
}/*
class Inscription extends StatelessWidget {
  final AuthService _authService = AuthService();
  final _formKey = GlobalKey<FormState>();
  String error = '';

  String email = '';
  String password = '';

  @override
  Widget build(BuildContext context) {
     TODO: implement build
    return new Container(padding: const EdgeInsets.all(0.0),
      child: new Column(
        children: <Widget>[
          new Text('Inscription',
            style : new TextStyle(
              fontSize: 40.0,
              fontFamily: 'Arvo',
            ),
            textAlign: TextAlign.center,
          ),
          new Expanded(
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
                          dynamic result = await _authService.registerWithEmailAndPassword(email, password);
                          if(result == null) {
                            setState(() {
                              error = 'Email non valide';
                            });
                          }
                        }
                      },
                    )
                  ],
                ),
              )
          )
        ],
      )
    );
  }
}*/