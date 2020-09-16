import 'package:flutter/material.dart';
import 'package:flutter_app/SqLite.dart';
import 'HomePage.dart';
import 'package:http/http.dart'as http;
void main() => runApp(MyApp());

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(

        primarySwatch: Colors.blue,
      ),
      home: SetupDb(),
    );
  }
}

class SetupDb extends StatefulWidget {
  @override
  _SetupDbState createState() => _SetupDbState();
}

class _SetupDbState extends State<SetupDb> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    CreatDb();
  }
   CreatDb()async{
    var database = SqLite();
    await database.setup();
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => HomePage()),
    );
   }

  @override
  Widget build(BuildContext context) {
    return Container(

    );
  }
}

