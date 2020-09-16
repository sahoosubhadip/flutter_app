import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_app/NotePadHome.dart';
import 'package:flutter_app/OTP.datr.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart'as http;

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  var verificationID;
  String phone = "";
  String code;
 // final GlobalKey<ScaffoldState> _scaffolkey = GlobalKey<ScaffoldState>();





  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //backgroundColor: Colors.white,
      body: SingleChildScrollView(
        padding: EdgeInsets.only(top: 25, left: 10, right: 10),
        child: Column(
          children: <Widget>[
            heading(),
            SizedBox(
              height: 0,
            ),
            note(),
            SizedBox(
              height: 0,
            ),
            backgroundImage(),
            SizedBox(
              height: 0,
            ),
            loginForm()
          ],
        ),
      ),
    );
  }

  heading() {
    return Center(
      child: Text(
        "- Smart Diary -",
        style: TextStyle(
            fontStyle: FontStyle.italic,
            color: Colors.blueGrey,
            fontWeight: FontWeight.w800,
            fontSize: 25),
      ),
    );
  }

  note() {
    return Center(
      child: Text(
        "_ The Digital - Smart and secure way  to memorise your important notes ...",
        style: TextStyle(
            fontStyle: FontStyle.italic,
            color: Colors.orange,
            fontWeight: FontWeight.w800,
            fontSize: 18),
      ),
    );
  }

  backgroundImage() {
    return Container(
      margin: EdgeInsets.only(top: 0),
      child: Image.asset(
        "assets/diary2.png",
        fit: BoxFit.cover,
        width: 165,
      ),
    );
  }

  loginForm() {
    return Container(
      width: MediaQuery.of(context).size.width,
      child: Column(
        children: <Widget>[
          TextFormField(
            decoration: InputDecoration(
              //border: OutlineInputBorder(),
              labelText: 'Email',
              hintText: 'abc@xyz.com',
              prefixIcon: Icon(
                Icons.email,
                color: Colors.red,
              ),
              suffixIcon: Icon(
                Icons.visibility,
                color: Colors.red,
              ),
            ),
          ),
          Container(
            height: 1,
          ),
          TextField(
            obscureText: true,
            decoration: InputDecoration(
              // border: OutlineInputBorder(),
              labelText: 'Password',
              hintText: 'Enter your password',
              prefixIcon: Icon(
                Icons.vpn_key,
                color: Colors.red,
              ),
              suffixIcon: Icon(
                Icons.visibility_off,
                color: Colors.red,
              ),
            ),
          ),
          Container(
            height: 10,
          ),
          RaisedButton(
            color: Colors.black12,
            textColor: Colors.orange,
            padding: EdgeInsets.only(left: 30, right: 30, top: 10, bottom: 10),
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(18.0),
                side: BorderSide(color: Colors.black)),
            onPressed: getdata,
           // {
              // Navigator.pushReplacement(
              //   context,
              //   MaterialPageRoute(builder: (context) => NotePadHome()),
              // );
           // },
            child: Text('Login', style: TextStyle(fontSize: 20)),
          ),
          Container(
            height: 5,
          ),
          Container(
            child: Text(
              '-  -  -  -  -  -  -  -  - OR -  -  -  -  -  -  -  -  -',
              style: TextStyle(
                  fontStyle: FontStyle.normal,
                  color: Colors.red,
                  fontWeight: FontWeight.bold,
                  fontSize: 20),
            ),
          ),
          Container(
            height: 0,
          ),
          TextFormField(
            keyboardType: TextInputType.number,
            decoration: InputDecoration(
              //border: OutlineInputBorder(),
              labelText: 'Phone',
              hintText: "Enter Your 10 digit Phone number ",
              prefixIcon: Icon(
                Icons.phone_iphone,
                color: Colors.red,
              ),
              suffixIcon: Icon(
                Icons.visibility,
                color: Colors.red,
              ),
            ),
            onChanged: (value) {
              setState(() {
                phone = value;
              });
            },
          ),
          Container(height: 10),
          RaisedButton(
            color: Colors.black12,
            textColor: Colors.orange,
            padding: EdgeInsets.only(left: 30, right: 30, top: 10, bottom: 10),
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(18.0),
                side: BorderSide(color: Colors.black)),
             onPressed: _auth,
            child: Text('Login Via OTP', style: TextStyle(fontSize: 20)),
          ),
        ],
      ),
    );
  }

  _auth() async {
    print(phone);
    String phoneNumber = "+91" + phone;
    firebaseAuth.verifyPhoneNumber(
        phoneNumber: phoneNumber,
        timeout: Duration(seconds: 60),
        verificationCompleted: verificationCompleted,
        verificationFailed: verificationFailed,
        codeSent: codeSend,
        codeAutoRetrievalTimeout: codeAutoRetrievalTimeout);
  }

  codeSend(String verificationId, [int forceResendingToken]) async {
    print("codeSend");
    print(verificationId);
    setState(() {
      verificationID = verificationId;
    });
  }

  codeAutoRetrievalTimeout(String verificationId) async {
    print("codeAutoRetrievalTimeout");
    print(verificationId);
    pageChange(verificationId);
  }

  verificationFailed(AuthException authException) async {
    print("verificationFailed");
    print(authException);

    print(authException.code);
    print(authException.message);
  }

  verificationCompleted(AuthCredential auth) async {
    print("verificationCompleted");
    final result = await firebaseAuth.signInWithCredential(auth);
    print(result.user.uid);


  }

  pageChange(verificationId) {
    Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) => OTP(verificationId, verificationID)),
    );
  }







 Future <void >getdata()async {
  var res= await http.get("https://api.github.com/users/sahoosubhadip") ;
  print(res);
  print(res.statusCode);
  print(res.body);
  }
}
