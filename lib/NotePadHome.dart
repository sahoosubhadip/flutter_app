import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/AddNote.dart';
import 'package:flutter_app/HomePage.dart';
import 'package:flutter_app/SqLite.dart';

class NotePadHome extends StatefulWidget {
  @override
  _NotePadHomeState createState() => _NotePadHomeState();
}

class _NotePadHomeState extends State<NotePadHome> {
  List note = [];
List title = [];


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _getNotes();
  }

  Future<void> _showChoiceDialogue(BuildContext context) {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            backgroundColor: Color(0xff201F23),
            title: Text(
              "Make a choice",
              style: TextStyle(color: Colors.red),
            ),
            content: SingleChildScrollView(
              child: ListBody(
                children: <Widget>[
                  Padding(padding: EdgeInsets.all(10.0)),
                  ListTile(
                    leading: Icon(
                      Icons.exit_to_app,
                      color: Colors.red,
                    ),
                    title: Text(
                      'Exit App',
                      style: TextStyle(color: Colors.red),
                    ),
                    onTap: () {},
                  ),
                  ListTile(
                    leading: Icon(
                      Icons.lock_outline,
                      color: Colors.red,
                    ),
                    title: Text(
                      'Logout  !',
                      style: TextStyle(color: Colors.red),
                    ),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => HomePage()),
                      );

                    },
                  ),
                  ListTile(
                    leading: Icon(
                      Icons.delete_forever,
                      color: Colors.red,
                    ),
                    title: Text(
                      'Delete My Account  !',
                      style: TextStyle(color: Colors.red),
                    ),
                    onTap: () {},
                  ),
                ],
              ),
            ),
            actions: [
              FlatButton(
                child: Text(
                  'Cancel',
                  style: TextStyle(color: Colors.red),
                ),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.orange,
      appBar: AppBar(
          leading: IconButton(
              icon: Icon(Icons.person, color: Colors.white),
              onPressed: () {
                _showChoiceDialogue(context);
              }),
          title: Text('Notes .  .  .',
              style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w800,
                  fontStyle: FontStyle.italic,
                  fontSize: 22)),
          backgroundColor: Colors.orange,
          // centerTitle: true,
          elevation: 5.0,
          actions: <Widget>[
            IconButton(
                icon: Icon(Icons.search, color: Colors.white),
                onPressed: () {}),
            IconButton(
                icon: Icon(Icons.add, color: Colors.white),
                onPressed: () async {
                  Route route =
                  MaterialPageRoute(builder: (context) => AddNote());
                  var returnBack = await Navigator.push(context, route);
                  await _getNotes();
                }
                )
          ]),
      body: ListView.builder(
          itemCount: title.length,
          itemBuilder: (BuildContext context, int index) {
        return Card(
          color: Colors.white,
          elevation: 2.0,
          child: ListTile(
            title: Text(title[index]['title'].toString()),
            trailing: GestureDetector(
              child:  Icon(
                Icons.delete,
                color: Colors.grey,
              ),

//              Row(
//                children: <Widget>[
//                  Icon(
//                    Icons.edit,
//                    color: Colors.grey,
//                  ),
//
//                ],
//              ),
              onTap: () { },
            ),

          ),
        );
      }),
    );
  }

  

  _getNotes()async{
    final id = await SqLite().getNote();
    setState(() {
title= id;
    });
  }


}
