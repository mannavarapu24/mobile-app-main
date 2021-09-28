import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
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
