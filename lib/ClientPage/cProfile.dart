import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../Shared/agentData.dart';
import '../widgets/ClientDrawer.dart';

class CProfile extends StatefulWidget {
  final User user;
  //const CProfile({Key? key}) : super(key: key);
  const CProfile({required this.user});
  @override
  State<CProfile> createState() => _CProfileState();
}

class _CProfileState extends State<CProfile> {
  final fireStore = FirebaseFirestore.instance;
  late User _currentUser;
  int currentIndex = 0;
  @override
  void initState() {
    _currentUser = widget.user;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: ClientNavigation(
        user: widget.user,
      ),
      appBar: AppBar(
        title: Text('My Profile'),
        elevation: 2,
      ),
      body: StreamBuilder<DocumentSnapshot<Map<String, dynamic>>>(
        stream:
            fireStore.collection('Clients').doc(widget.user.uid).snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Center(
              child: Text(snapshot.error?.toString() ?? ''),
            );
          }
          if (snapshot.hasData) {
            final data = snapshot.data?.data();
            if (data != null) {
              final client = ClientData.froJson(data);
              return SingleChildScrollView(
                child: Container(
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 70),
                    child: Center(
                      child: Card(
                        elevation: 3,
                        shape: RoundedRectangleBorder(
                          side: BorderSide(
                            color: Theme.of(context).colorScheme.surfaceVariant,
                          ),
                        ),
                        child: SizedBox(
                          height: 500,
                          width: 500,
                          child: Column(
                            children: <Widget>[
                              SizedBox(
                                height: 40,
                              ),
                              CircleAvatar(
                                backgroundImage:
                                    AssetImage('assets/HL_M65_01.jpg'),
                                radius: 40,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              );
            }
          }
          return Center(
            child: CircularProgressIndicator(
              backgroundColor: Colors.white,
              color: Colors.red,
            ),
          );
        },
      ),
    );
  }
}
