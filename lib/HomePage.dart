import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        padding: EdgeInsets.only(top: 35, left: 10, right: 10),
        child: Column(
          children: <Widget>[
            heading(),
            backgroundImage(),
            loginForm()
          ],
        ),
      ),
    );
  }

  heading() {
    return Center(
      child: Text("Welcome Back!", style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),),
    );
  }

  backgroundImage() {
    return Container(
      margin: EdgeInsets.only(top: 20),
      child: Image.asset("assets/background.png", fit: BoxFit.cover, width: 300,),
    );
  }

  loginForm() {
    return Container(
      width: MediaQuery.of(context).size.width,
      child: Column(
        children: <Widget>[

          TextField(
            decoration: InputDecoration(
              border: OutlineInputBorder(),
              labelText: 'Email',
              prefixIcon: Icon(Icons.email),
              suffixIcon: Icon(Icons.visibility),
            ),
          ),

          Container(height: 15,),

          TextField(
            obscureText: true,
            decoration: InputDecoration(
              border: OutlineInputBorder(),
              labelText: 'Password',
              prefixIcon: Icon(Icons.vpn_key),
              suffixIcon: Icon(Icons.visibility_off),
            ),
          ),

          Container(height: 15,),

          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: <Widget>[
              Expanded(child: Container()),
              Expanded(child: InkWell(
                onTap: (){
                  print("Forgot Password");
                },
                  child: Text("Forgot Password", textAlign: TextAlign.right,))
              ),
            ],
          ),


          RaisedButton(
            color: Colors.blue,
            textColor: Colors.white,
            padding: EdgeInsets.only(left: 30, right: 30, top: 10, bottom: 10),
            shape: RoundedRectangleBorder( borderRadius: BorderRadius.circular(18.0), side: BorderSide(color: Colors.blueAccent)),
            onPressed: (){
            },
            child: Text( 'Login', style: TextStyle(fontSize: 20)
            ),
          ),

          Container(height: 15,),

          InkWell(
            onTap: (){},
            child: Text("Login Via OTP", style: TextStyle(color: Colors.blue, fontWeight: FontWeight.bold, fontSize: 18),),
          ),
          Container(height: 15,),
          Container(
            width: MediaQuery.of(context).size.width,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Icon(Icons.face),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Icon(Icons.visibility_off),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

}
