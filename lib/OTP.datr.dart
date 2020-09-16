import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/NotePadHome.dart';

class OTP extends StatefulWidget {
  final String verificationID ;
  OTP(verificationId, this.verificationID);

  @override
  _OTPState createState() => _OTPState();
}

class _OTPState extends State<OTP> {
  final FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  String phone = "";
  String code;
  final GlobalKey<ScaffoldState> _scaffolkey = GlobalKey<ScaffoldState>();

  String otp = " ";
  var verificationID;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //backgroundColor: Colors.grey,

      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            text(),
            Container(
              margin: EdgeInsets.only(top: 20),
              child: Image.asset(
                "assets/pen.png",
                fit: BoxFit.fill,
                width: 250,
              ),
            ),
            sms(),
            Container(
              height: 10,
            ),
            button(context),
          ],
        ),
      ),
    );
  }


  __login() async {
    print(verificationID);
    final credential = await PhoneAuthProvider.getCredential(
        verificationId:widget.verificationID , smsCode: otp);
    try {
      final result = await firebaseAuth.signInWithCredential(credential);
     // await ServerAPI().setAuthUser({'phone': phone,'name':name,'api_token':result.user.uid.toString() }) ;

      print(result.user.uid);
    } catch (e) {
      print(e);
    }

    NextHomePage();
  }



  button(context) {
    return Center(
      child: RaisedButton(
        color: Colors.black12,
        textColor: Colors.white,
        padding: EdgeInsets.only(left: 8, right: 8, top: 10, bottom: 10),
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(18.0),
            side: BorderSide(color: Colors.white)),
          onPressed: () async {

            await __login();
          },
        child: Text('Verify & Login', style: TextStyle(fontSize: 17)),
      ),
    );
  }

  text() {
    return Center(
      heightFactor: 3,
      child: Text(
        "OTP Verification ",
        style: TextStyle(
            fontSize: 25, color: Colors.blueGrey, fontWeight: FontWeight.w900,fontStyle: FontStyle.italic),
      ),
    );
  }

  sms() {
    return Container(
      width: MediaQuery.of(context).size.width,
      child: Column(
        children: <Widget>[
          Padding(
            padding: EdgeInsets.only(left: 30, right: 30, top: 25),
            child: TextField(
              keyboardType: TextInputType.number,
              onChanged: (value) {
                otp = value;
              },
              obscureText: true,
              decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: "OTP",
                  hintText: "---     ---     ---     ---     ---     ---",
                  prefixIcon: Icon(Icons.sms),
                  suffixIcon: Icon(Icons.visibility_off,color: Colors.red,)),
            ),
          ),
          Container(
            height: 15,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: <Widget>[
              Expanded(child: Container()),
              Expanded(
                  child: InkWell(
                      onTap: () {},
                      child: Text(
                        "Resend OTP",
                        style: TextStyle(
                            color: Colors.blueAccent,
                            fontWeight: FontWeight.w800,
                            fontSize: 17),
                        textAlign: TextAlign.right,
                      ))),
            ],
          ),
        ],
      ),
    );
  }


  NextHomePage() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => NotePadHome()),
    );
  }


}
