import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ConnexionPage extends StatefulWidget {
  @override
  ConnexionPageState createState() {
    return new ConnexionPageState();
  }
}

class ConnexionPageState extends State<ConnexionPage> {

  String id;
  final db = Firestore.instance;
  final _formKey = GlobalKey<FormState>();
  String name;

  Card buildItem(DocumentSnapshot documentSnapshot) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              'name: ${documentSnapshot.data['name']}',
              style: TextStyle(fontSize: 24),
            ),
            Text(
              'todo: ${documentSnapshot.data['todo']}',
              style: TextStyle(fontSize: 20),
            ),
            SizedBox(height: 12,),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                FlatButton(
                  onPressed: () => updateData(documentSnapshot),
                  child: Text('Update Todo',),
                  color: Colors.green,
                ),
                SizedBox(width: 8,),
                FlatButton(
                  onPressed: () => deleteData(documentSnapshot),
                  child: Text('Delete'),
                  color: Colors.red,
                )
              ],
            )
          ],
        ),
      ),
    );
  }

  Color couleurPrincipale = const Color(0xff3C3261);

  TextFormField buildTextFormField() {
    return TextFormField(
      decoration: InputDecoration(
        border: InputBorder.none,
        hintText: 'name',
        fillColor: Colors.grey[300],
        filled: true,
      ),
      validator: (value) {
        if (value.isEmpty) {
          return 'Entrer du texte ici';
        }
      },
      onSaved: (value) => name = value,
    );
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return new Scaffold(
      backgroundColor: Colors.white,
      appBar: new AppBar(
        elevation: 0.3,
        centerTitle: true,
        backgroundColor: Colors.white,
        title: new Text('Le Cinéphil\'',
        style: new TextStyle(
          color: couleurPrincipale,
          fontFamily: 'Arvo',
          fontWeight: FontWeight.bold,
        ),),
      ),
      body: new Padding(padding: const EdgeInsets.all(16.0),
        child: new Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            new ConnexionBody(couleurPrincipale),
            ///Debut du formulaire de connexion
            new Expanded(child: ListView(
              padding: EdgeInsets.all(8),
              children: <Widget>[
                Form(
                  key: _formKey,
                  child: buildTextFormField(),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    RaisedButton(
                      onPressed: createData,
                      child: Text('Créer',),
                      color: Colors.green,
                    ),
                    RaisedButton(
                      onPressed: id != null ? readData : null,
                      child: Text('Read'),
                      color: Colors.blue,
                    ),
                  ],
                ),
                StreamBuilder<QuerySnapshot>(
                  stream: db.collection('CRUD').snapshots(),
                  builder: (context, snapshot) {
                    if(snapshot.hasData) {
                      return Column(children: snapshot.data.documents.map((doc) => buildItem(doc)).toList());
                    } else {
                      return SizedBox();
                    }
                  },
                )
              ],
            ))
          ],
        ),),
    );
  }

  void createData() async {
    if (_formKey.currentState.validate()) {
      _formKey.currentState.save();
      DocumentReference ref = await db.collection('CRUD').add({'name': '$name', 'todo': randomTodo()});
      setState(() => id = ref.documentID);
      print(ref.documentID);
    }
  }
  void readData() async {
    DocumentSnapshot snapshot = await db.collection('CRUD').document(id).get();
    print(snapshot.data['name']);
  }
  
  void updateData(DocumentSnapshot doc) async {
    await db.collection('CRUD').document(doc.documentID).updateData({'todo': 'please ?'});
  }
  void deleteData(DocumentSnapshot doc) async {
    await db.collection('CRUD').document(doc.documentID).delete();
    setState(() {
      id = null;
    });
  }
  String randomTodo(){
    final randomNumber = Random().nextInt(4);
    String todo;
    switch (randomNumber) {
      case 1:
        todo = 'Manger de la moutarde';
        break;
      case 2:
        todo = 'Faire la vaisselle';
        break;
      case 3:
        todo = 'Ranger le linge dans la voiture';
        break;
      default:
        todo = 'Acheter des mouchoirs comme il fait froid';
        break;
    }
    return todo;
  }
}

class ConnexionBody extends StatelessWidget{

  final Color couleurPrincipale;

  ConnexionBody(this.couleurPrincipale);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return new Padding(padding: const EdgeInsets.all(0.0),
      child: new Text(
          'Connexion',
        style: new TextStyle(
          fontSize: 40.0,
          color: couleurPrincipale,
          fontWeight: FontWeight.bold,
          fontFamily: 'Arvo',
        ),
        textAlign: TextAlign.center,
      ),);
  }

}