import 'package:estatemanagement/ScreenPages/LoginPage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({
    Key? key,
    required this.user,
  }) : super(key: key);
  final User user;
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text('INFORMATION'),
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Center(
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 30, vertical: 70),
                child: Card(
                  elevation: 2,
                  shape: RoundedRectangleBorder(
                    side: BorderSide(
                      color: Theme.of(context).colorScheme.surfaceVariant,
                    ),
                  ),
                  child: SizedBox(
                    height: 600,
                    width: 1700,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 20),
                      child: Column(
                        children: <Widget>[
                          const SizedBox(
                            height: 10,
                          ),
                          const Expanded(
                            child: Text(
                              'An agent, in legal terminology, is a person who has been legally empowered to act on behalf of another person or an entity. '
                              'An agent may be employed to represent a client in negotiations and other dealings with third parties. '
                              'The agent may be given decision-making authority.',
                              style: TextStyle(
                                color: Colors.red,
                                fontWeight: FontWeight.bold,
                                letterSpacing: 3,
                              ),
                            ),
                          ),
                          TextButton(
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          LoginPage(user: widget.user)));
                            },
                            child: const Text(
                              'Agent Click here',
                              style: TextStyle(
                                  color: Colors.blue,
                                  letterSpacing: 2,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                          // SizedBox(
                          //   height: 20,
                          // ),
                          const Divider(
                            height: 20,
                            thickness: 2,
                          ),
                          const Expanded(
                            child: Padding(
                              padding: EdgeInsets.all(20),
                              child: Text(
                                'A client is an individual or organization that seeks the services or advice of another person or entity, known as the service provider or advisor. The client may require assistance in various areas, such as legal, financial, real estate, or consulting.',
                                style: TextStyle(
                                  color: Colors.red,
                                  fontWeight: FontWeight.bold,
                                  letterSpacing: 2,
                                ),
                              ),
                            ),
                          ),
                          TextButton(
                            onPressed: () {
                              // Navigator.push(
                              //     context,
                              //     MaterialPageRoute(
                              //         builder: (context) => const clientLogin(
                              //                user: widget.user
                              //             )));
                            },
                            child: const Text(
                              'Client Click here',
                              style: TextStyle(
                                  color: Colors.blue,
                                  letterSpacing: 2,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
