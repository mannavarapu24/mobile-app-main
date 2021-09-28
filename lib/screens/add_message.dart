import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AddMessage extends StatefulWidget {
  AddMessage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  _AddMessageState createState() => _AddMessageState();
}

class _AddMessageState extends State<AddMessage> {
  final _auth = FirebaseAuth.instance;
  FirebaseFirestore _firestore = FirebaseFirestore.instance;
  String data = "";
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    GoogleSignIn _googleSignIn = GoogleSignIn();
    return Scaffold(
        appBar: AppBar(
          // Here we take the value from the MyHomePage object that was created by
          // the App.build method, and use it to set our appbar title.
          title: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Expanded(
                  child: Align(
                      alignment: Alignment.topRight,
                      child: Text(widget.title))),
              Container(
                width: size.width * 0.28,
                child: Align(
                  alignment: Alignment.topRight,
                  child:  FlatButton(
                      onPressed: () => showDialog<String>(
                          context: context,
                          builder:(BuildContext context) =>  Padding(
                            padding:  EdgeInsets.symmetric(horizontal: size.width*0.1,vertical: size.height*0.15),
                            child: Container(
                              decoration: BoxDecoration(
                                color: Color(0xff6EBCFF).withOpacity(0.85),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Column(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(16.0),
                                    child: Row(
                                      children: [
                                        Expanded(child: Align(alignment:Alignment.topRight,child: GestureDetector(onTap: (){Navigator.pop(context);},child: Icon(Icons.clear,color: Colors.white,size: size.width*0.08,))))
                                      ],
                                    ),
                                  ),
                                  Padding(
                                    padding:  EdgeInsets.symmetric(horizontal: size.width*0.1),
                                    child: Container(
                                      height: size.height*0.5,
                                      child: Column(
                                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                        children: [
                                          Text("Logging Out?",style: TextStyle(
                                            fontSize: size.width * 0.07,
                                            color: Colors.white,
                                            decoration: TextDecoration.none,),),
                                          Column(
                                            children: [
                                              Text("Your data will be saved and you are always\n",style: TextStyle(
                                                fontSize: size.width * 0.025,
                                                color: Colors.white,
                                                decoration: TextDecoration.none,),),
                                              Text("Welcome Back!",style: TextStyle(
                                                fontSize: size.width * 0.025,
                                                color: Colors.white,
                                                decoration: TextDecoration.none,),),
                                            ],
                                          ),
                                          GestureDetector(
                                            onTap: () {
                                              _auth.signOut();
                                              _googleSignIn.signOut();
                                              Navigator.pushNamed(context, '/home');
                                            },
                                            child: Container(
                                              width: size.width*0.4,
                                              decoration: BoxDecoration(
                                                  borderRadius: BorderRadius.circular(40),
                                                  color: Colors.transparent,
                                                  border: Border.all(color: Colors.white,width: 1)
                                              ),
                                              child: Center(
                                                child: Container(
                                                  padding: EdgeInsets.all(20),
                                                  child: Text(
                                                    'Logout',
                                                    style: TextStyle(
                                                        color: Colors.white,
                                                        fontSize: size.width*0.042,
                                                        decoration: TextDecoration.none),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),


                                        ],
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            ),
                          )
                      ),
                      child: Text(
                        'LogOut',
                        style: TextStyle(fontSize: 12,color: Colors.white),
                      )),
                ),
              ),
            ],
          ),
        ),
        body: ListView(
          children: [
            Center(
              child: Padding(
                padding: EdgeInsets.only(top: size.height * 0.03),
                child: Container(
                  width: size.width * 0.92,
                  height: size.height * 0.84,
                  decoration: BoxDecoration(
                    color: Color.fromRGBO(229, 229, 229, 0.6),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Row(
                          children: [
                            Expanded(
                                child: Align(
                                    alignment: Alignment.topRight,
                                    child: GestureDetector(
                                        onTap: () {
                                          Navigator.pop(context);
                                        },
                                        child: Icon(
                                          Icons.clear,
                                          color: Color(0xff757575),
                                          size: size.width * 0.08,
                                        ))))
                          ],
                        ),
                      ),
                      Padding(
                        padding:
                            EdgeInsets.symmetric(horizontal: size.width * 0.1),
                        child: Column(
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(10),
                              ),
                              height: size.height * 0.6,
                              child: Padding(
                                padding: const EdgeInsets.all(20.0),
                                child: TextField(
                                  onChanged: (value) {
                                    data = value;
                                  },
                                  maxLines: 100,
                                  style: TextStyle(
                                      fontSize: 20, color: Colors.grey),
                                  decoration: InputDecoration(
                                    border: InputBorder.none,
                                    focusedBorder: InputBorder.none,
                                    enabledBorder: InputBorder.none,
                                    errorBorder: InputBorder.none,
                                    disabledBorder: InputBorder.none,
                                  ),
                                ),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.symmetric(
                                  vertical: size.height * 0.035),
                              child: GestureDetector(
                                onTap: () {
                                  DateTime messageDate = DateTime.now();
                                  Timestamp messageStamp =
                                      Timestamp.fromDate(messageDate);
                                  _firestore.collection("messages").add(
                                      {'message': data, 'date': messageStamp});
                                  Navigator.pushNamed(context, '/admin');
                                },
                                child: Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(30),
                                    color: Colors.blue,
                                  ),
                                  child: Center(
                                    child: Container(
                                      padding: EdgeInsets.all(15),
                                      child: Text(
                                        'Add Message',
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: size.width * 0.042,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
          ],
        ));
  }
}
