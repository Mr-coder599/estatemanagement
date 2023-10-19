import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:estatemanagement/ClientPage/CLogin.dart';
import 'package:estatemanagement/ScreenPages/LoginPage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
      // options: DefaultFirebaseOptions.currentPlatform,
      );

  runApp(MaterialApp(
    theme: ThemeData(primaryColor: Colors.deepOrangeAccent),
    debugShowCheckedModeBanner: false,
    home: SplashScreen(),
  ));
}

class SplashScreen extends StatefulWidget {
  const SplashScreen({
    Key? key,
  }) : super(key: key);

  //get user => null;

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  late final StreamSubscription _subscription;
  late FirebaseFirestore firestore;
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 5), () {
      _subscription = FirebaseAuth.instance.authStateChanges().listen((user) {
        if (user != null) {
          Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => LoginPage(
                    user: user,
                  )));
          return;
        } else {
          Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => clientLogin(user: widget.user)));
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: StreamBuilder<User?>(
            stream: FirebaseAuth.instance.authStateChanges(),
            builder: (context, snapshot) {
              if (snapshot.hasError) {
                return Center(
                  child: Text(snapshot.error?.toString() ?? ''),
                );
              }
              return Stack(
                fit: StackFit.expand,
                children: <Widget>[
                  Container(
                    decoration: const BoxDecoration(color: Colors.orangeAccent),
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      Expanded(
                        flex: 2,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            SizedBox(
                              height: 260.0,
                            ),
                            CircleAvatar(
                              backgroundColor: Colors.white,
                              radius: 50.0,
                              child: Icon(
                                Icons.other_houses_sharp,
                                color: Colors.greenAccent,
                                size: 50.0,
                              ),
                            ),
                            SizedBox(
                              height: 30.0,
                            ),
                            Padding(
                              padding: EdgeInsets.only(top: 10.0),
                            ),
                            Text(
                              'Real Estate Management System',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 20.0,
                                  fontWeight: FontWeight.bold),
                            ),
                            Expanded(
                              flex: 2,
                              child: Container(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: <Widget>[
                                    CircularProgressIndicator(),
                                    Padding(
                                      padding: EdgeInsets.only(top: 20.0),
                                    ),
                                    Text(
                                      'Developed by Hibertech Solution',
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 12.0),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              );
            }));
  }
}
