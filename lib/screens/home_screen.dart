import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:otp_text_field/otp_field.dart';
import 'package:otp_text_field/style.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:otp_text_field/otp_field.dart';
import 'package:otp_text_field/style.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}


class _HomeState extends State<Home> {
  var _verificationId;
  var authClassObj;
  loginbyanonymous() async{
    FirebaseAuth.instance.signInAnonymously();
  }
  Future<UserCredential> Facebook() async {
    final AccessToken result = await FacebookAuth.instance.login();

    final OAuthCredential facebookAuthCredential =
    FacebookAuthProvider.credential(result.token);

    return await FirebaseAuth.instance
        .signInWithCredential(facebookAuthCredential);
  }
  String _verid = '';
  void loginbynumber (BuildContext context) async {
    TextEditingController phone = TextEditingController();
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
              title: Text('Enter your Phone Number'),
              content: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    TextField(
                      onChanged: (value) {
                        setState(() {
                          //valueText = value;
                        });
                      },
                      controller: phone,
                      decoration: InputDecoration(hintText: "Enter Phone"),
                    ),
                    Expanded(
                      child: OTPTextField(
                        length: 6,
                        width: MediaQuery.of(context).size.width,
                        textFieldAlignment: MainAxisAlignment.spaceAround,
                        fieldWidth: 30,
                        fieldStyle: FieldStyle.underline,
                        outlineBorderRadius: 10,
                        style: TextStyle(fontSize: 20),
                        onChanged: (pin) {
                          print("Changed: " + pin);
                        },
                        onCompleted: (pin) {
                          authClassObj.verify(pin, _verid).then((value) =>
                              Navigator.pushReplacementNamed(context, "/"));
                        },
                      ),
                    )
                  ]),
              actions: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    FlatButton(
                      color: Colors.red,
                      textColor: Colors.white,
                      child: Text('Cancel'),
                      onPressed: () {
                        setState(() {
                          Navigator.pop(context);
                          //Navigator.pushNamed(context, '/Login');
                        });
                      },
                    ),
                    FlatButton(
                      color: Colors.blueAccent,
                      textColor: Colors.white,
                      child: Text('Get Code'),
                      onPressed: () {
                        setState(() {
                          _verid = send_code(phone.text.trim()).toString();

                        });
                      },
                    ),
                  ],
                )
              ]);
        });
  }

  Future<String> send_code(String phone) async {
    await FirebaseAuth.instance.verifyPhoneNumber(
      phoneNumber: phone,
      verificationCompleted: (PhoneAuthCredential phoneAuthCredential) {},
      codeSent: (String verificationId, int? forceResendingToken) {
        _verificationId = verificationId;
      },
      verificationFailed: (FirebaseAuthException error) {},
      codeAutoRetrievalTimeout: (String verificationId) {},
    );
    return _verificationId;
  }

  Future<void> verify(String code, String verid) async {
    print('verid: ' + _verificationId);

    AuthCredential credential = PhoneAuthProvider.credential(
        smsCode: code, verificationId: _verificationId);

    await FirebaseAuth.instance.signInWithCredential(credential);
  }


  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: Container(
        height: size.height,
        width: size.width,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/big.jpg'),
            fit: BoxFit.fitHeight,
          ),
        ),
        child: Container(
          height: size.height,
          width: size.width,
          //color: Colors.grey.withOpacity(0.5),
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: size.height * 0.08),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 32.0),
                  child: Container(
                    width: size.width * 0.7,
                    child: Row(
                      children: [
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.only(right: 10.0),
                            child: GestureDetector(
                              onTap: () {
                                Navigator.pushNamed(context, '/register');
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(42),
                                  color: Colors.blueAccent,
                                ),
                                child: Center(
                                  child: Container(
                                    padding: EdgeInsets.all(11),
                                    child: Text(
                                      'Sign Up',
                                      style: TextStyle(
                                        color: Colors.pinkAccent,
                                        fontSize: size.width * 0.060,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.only(right: 10.0),
                            child: GestureDetector(
                              onTap:Facebook

                                //Navigator.pushNamed(context, '/register');
                              ,
                              child: Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(42),
                                  color: Colors.blueAccent,
                                ),
                                child: Center(
                                  child: Container(
                                    padding: EdgeInsets.all(11),
                                    child: Text(
                                      'Facebook',
                                      style: TextStyle(
                                        color: Colors.pinkAccent,
                                        fontSize: size.width * 0.060,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.only(right: 10.0),
                            child: GestureDetector(
                              onTap: loginbynumber,
                              child: Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(42),
                                  color: Colors.blueAccent,
                                ),
                                child: Center(
                                  child: Container(
                                    padding: EdgeInsets.all(11),
                                    child: Text(
                                      'Number',
                                      style: TextStyle(
                                        color: Colors.pinkAccent,
                                        fontSize: size.width * 0.060,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.only(right: 10.0),
                            child: GestureDetector(
                              onTap: loginbyanonymous,
                              child: Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(42),
                                  color: Colors.blueAccent,
                                ),
                                child: Center(
                                  child: Container(
                                    padding: EdgeInsets.all(11),
                                    child: Text(
                                      'anonyomus',
                                      style: TextStyle(
                                        color: Colors.pinkAccent,
                                        fontSize: size.width * 0.060,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.only(left: 10.0),
                            child: GestureDetector(
                              onTap: () {
                                Navigator.pushNamed( context, '/login');
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(40),
                                  color: Colors.lightBlueAccent,
                                  border: Border.all(
                                      color: Colors.lightGreen, width: 1),
                                ),
                                child: Center(
                                  child: Container(
                                    padding: EdgeInsets.all(10),
                                    child: Text(
                                      'Login',
                                      style: TextStyle(
                                        color: Colors.pinkAccent,
                                        fontSize: size.width * 0.050,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
