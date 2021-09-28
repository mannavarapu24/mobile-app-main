import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:intl/intl.dart';

class AdminMessage extends StatefulWidget {
  AdminMessage({Key? key, required this.title}) : super(key: key);

  final String title;
  @override
  _AdminMessageState createState() => _AdminMessageState();
}

class _AdminMessageState extends State<AdminMessage> {
  final _auth = FirebaseAuth.instance;
  late User loggedInUser;
  FirebaseFirestore _firestore = FirebaseFirestore.instance;
  @override
  void initState() {
    // ignore: todo
    // TODO: implement initState
    super.initState();
    getCurrentUser();
  }

  void getCurrentUser() async {
    final user = _auth.currentUser!;
    loggedInUser = user;
    print(loggedInUser.email);
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    var currentEmail = "mahalakshmiammalu@gmail.com";
    GoogleSignIn _googleSignIn = GoogleSignIn();
    if (loggedInUser.email == currentEmail) {
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
                width: size.width * 0.38,
                child: Align(
                  alignment: Alignment.topRight,
                  child: TextButton(
                      onPressed: () => showDialog<String>(
                          context: context,
                          builder: (BuildContext context) => Padding(
                                padding: EdgeInsets.symmetric(
                                    horizontal: size.width * 0.1,
                                    vertical: size.height * 0.15),
                                child: Container(
                                  decoration: BoxDecoration(
                                    color: Color(0xff808080).withOpacity(0.100),
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
                                                    alignment:
                                                        Alignment.topCenter,
                                                    child: GestureDetector(
                                                        onTap: () {
                                                          Navigator.pop(
                                                              context);
                                                        },
                                                        child: Icon(
                                                          Icons.clear,
                                                          color:
                                                              Colors.lightGreen,
                                                          size:
                                                              size.width * 0.20,
                                                        ))))
                                          ],
                                        ),
                                      ),
                                      Padding(
                                        padding: EdgeInsets.symmetric(
                                            horizontal: size.width * 0.1),
                                        child: Container(
                                          height: size.height * 0.5,
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceEvenly,
                                            children: [
                                              GestureDetector(
                                                onTap: () {
                                                  _auth.signOut();
                                                  _googleSignIn.signOut();
                                                  Navigator.pushNamed(
                                                      context, '/home');
                                                },
                                                child: Container(
                                                  width: size.width * 0.4,
                                                  decoration: BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              40),
                                                      color: Colors.transparent,
                                                      border: Border.all(
                                                          color: Colors.white,
                                                          width: 1)),
                                                  child: Center(
                                                    child: Container(
                                                      padding:
                                                          EdgeInsets.all(20),
                                                      child: Text(
                                                        'Logout',
                                                        style: TextStyle(
                                                            color: Colors.white,
                                                            fontSize:
                                                                size.width *
                                                                    0.042,
                                                            decoration:
                                                                TextDecoration
                                                                    .none),
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
                              )),
                      child: Text(
                        'LogOut',
                        style: TextStyle(fontSize: 12, color: Colors.white),
                      )),
                ),
              ),
            ],
          ),
        ),
        body: ListView(
          children: [
            Padding(
              padding: EdgeInsets.all(size.width * 0.1),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: size.height * 0.01),
                    child: Text(
                      '',
                      style: TextStyle(
                          fontSize: size.width * 0.05, color: Colors.grey),
                    ),
                  ),
                  StreamBuilder<QuerySnapshot>(
                      stream: _firestore.collection("messages").snapshots(),
                      builder: (context, snapshot) {
                        if (snapshot.hasData) {
                          final messages = snapshot.data;
                          List<messageCard> messageWidgets = [];

                          for (var message in messages!.docs) {
                            var text = message["message"];
                            var msgStamp = message["date"];
                            var msgDate = msgStamp.toDate().day.toString();
                            var msgMonth =
                                DateFormat('MMMM').format(msgStamp.toDate());
                            var msgYear = msgStamp.toDate().year.toString();
                            final messageWidget = messageCard(
                              text: text,
                              date: msgDate,
                              month: msgMonth,
                              year: msgYear,
                            );
                            messageWidgets.add(messageWidget);
                          }
                          return Column(
                            children: messageWidgets,
                          );
                        } else {
                          return Container();
                        }
                      }),
                ],
              ),
            ),
          ],
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.pushNamed(context, '/add');
          },
          tooltip: 'Increment',
          child: Icon(Icons.add),
        ), // This trailing comma makes auto-formatting nicer for build methods.
      );
    } else {
      return Scaffold(
        appBar: AppBar(
          // Here we take the value from the MyHomePage object that was created by
          // the App.build method, and use it to set our appbar title.
          title: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Expanded(
                  child: Align(alignment: Alignment.topRight, child: Text(''))),
              Container(
                width: size.width * 0.38,
                child: Align(
                  alignment: Alignment.topRight,
                  child: TextButton(
                      onPressed: () => showDialog<String>(
                          context: context,
                          builder: (BuildContext context) => Padding(
                                padding: EdgeInsets.symmetric(
                                    horizontal: size.width * 0.1,
                                    vertical: size.height * 0.15),
                                child: Container(
                                  decoration: BoxDecoration(
                                    color: Color(0xff808080).withOpacity(0.100),
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
                                                    alignment:
                                                        Alignment.topCenter,
                                                    child: GestureDetector(
                                                        onTap: () {
                                                          Navigator.pop(
                                                              context);
                                                        },
                                                        child: Icon(
                                                          Icons.clear,
                                                          color:
                                                              Colors.lightGreen,
                                                          size:
                                                              size.width * 0.20,
                                                        ))))
                                          ],
                                        ),
                                      ),
                                      Padding(
                                        padding: EdgeInsets.symmetric(
                                            horizontal: size.width * 0.1),
                                        child: Container(
                                          height: size.height * 0.5,
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceEvenly,
                                            children: [
                                              GestureDetector(
                                                onTap: () {
                                                  _auth.signOut();
                                                  _googleSignIn.signOut();
                                                  Navigator.pushNamed(
                                                      context, '/home');
                                                },
                                                child: Container(
                                                  width: size.width * 0.4,
                                                  decoration: BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              40),
                                                      color: Colors.transparent,
                                                      border: Border.all(
                                                          color: Colors.white,
                                                          width: 1)),
                                                  child: Center(
                                                    child: Container(
                                                      padding:
                                                          EdgeInsets.all(20),
                                                      child: Text(
                                                        'Log Out',
                                                        style: TextStyle(
                                                            color: Colors.white,
                                                            fontSize:
                                                                size.width *
                                                                    0.042,
                                                            decoration:
                                                                TextDecoration
                                                                    .none),
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
                              )),
                      child: Text(
                        'LogOut',
                        style: TextStyle(fontSize: 12, color: Colors.white),
                      )),
                ),
              ),
            ],
          ),
        ),
        body: ListView(
          children: [
            Padding(
              padding: EdgeInsets.all(size.width * 0.1),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: size.height * 0.01),
                  ),
                  StreamBuilder<QuerySnapshot>(
                      stream: _firestore
                          .collection("messages")
                          .orderBy(
                            'date',
                          )
                          .snapshots(),
                      builder: (context, snapshot) {
                        if (snapshot.hasData) {
                          final messages = snapshot.data;
                          List<messageCard> messageWidgets = [];

                          for (var message in messages!.docs) {
                            var text = message["message"];
                            var msgStamp = message["date"];
                            var msgDate = msgStamp.toDate().day.toString();
                            var msgMonth =
                                DateFormat('MMMM').format(msgStamp.toDate());
                            var msgYear = msgStamp.toDate().year.toString();
                            final messageWidget = messageCard(
                              text: text,
                              date: msgDate,
                              month: msgMonth,
                              year: msgYear,
                            );
                            messageWidgets.add(messageWidget);
                          }
                          return Column(
                            children: messageWidgets,
                          );
                        } else {
                          return Container();
                        }
                      }),
                ],
              ),
            ),
          ],
        ),
      );
    }
  }
}

// ignore: camel_case_types
class messageCard extends StatelessWidget {
  messageCard({this.date, this.text, this.month, this.year});
  final text;
  final date;
  final month;
  final year;
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 20.0),
      child: Row(
        children: [
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.white12,
                    blurRadius: 20.0,
                  ),
                ],
                borderRadius: BorderRadius.all(Radius.circular(12)),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(14.0),
                    child: Text(
                      text,
                      style: TextStyle(
                          color: Color(0xff303030),
                          fontSize: size.width * 0.04),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(14.0),
                    child: Text(
                      date + " " + month + " " + year,
                      style: TextStyle(
                          color: Color(0xff757575),
                          fontSize: size.width * 0.028),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
