import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:estatemanagement/Shared/agentData.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../widgets/AgentDrawer.dart';

class AgentDashboard extends StatefulWidget {
  const AgentDashboard({Key? key, required this.user}) : super(key: key);
  final User user;
  @override
  State<AgentDashboard> createState() => _AgentDashboardState();
}

class _AgentDashboardState extends State<AgentDashboard> {
  final fireStore = FirebaseFirestore.instance;
  var size, height, width;
  @override
  Widget build(BuildContext context) {
    // size = MediaQuery.of(context).size;
    // height = size.height;
    // width = size.width;
    return Scaffold(
      drawer: DrawerAgent(
        user: widget.user,
      ),
      appBar: AppBar(
        backgroundColor: Colors.orange,
        title: Text('Agent Profile'),
        elevation: 0,
        centerTitle: true,
      ),
      body: StreamBuilder<DocumentSnapshot<Map<String, dynamic>>>(
        stream: fireStore.collection('Agent').doc(widget.user.uid).snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Center(
              child: Text(snapshot.error?.toString() ?? ''),
            );
          }
          if (snapshot.hasData) {
            final data = snapshot.data?.data();
            if (data != null) {
              final AgentData = AgentInfo.froJson(data);
              return SingleChildScrollView(
                child: Container(
                  child: Padding(
                    padding:
                        EdgeInsets.symmetric(horizontal: 20.0, vertical: 30.0),
                    child: Center(
                      child: Flexible(
                        child: Card(
                          elevation: 2,
                          shape: RoundedRectangleBorder(
                            side: BorderSide(
                              color:
                                  Theme.of(context).colorScheme.surfaceVariant,
                            ),
                          ),
                          child: SizedBox(
                            height: 500,
                            width: 600,
                            child: Column(
                              mainAxisSize: MainAxisSize.max,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                SizedBox(
                                  height: 60.0,
                                ),
                                Center(
                                  child: CircleAvatar(
                                    backgroundImage:
                                        AssetImage('assets/estateone.webp'),
                                    radius: 60,
                                  ),
                                ),
                                Center(
                                  child: Text(
                                    'Login as:' + ' ' + ''
                                    //   widget.user.email.toString(),
                                    ,
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold),
                                  ),
                                ),
                                Divider(
                                  thickness: 2,
                                  color: Colors.green,
                                ),
                                SizedBox(
                                  height: 20.0,
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    SizedBox(
                                      height: 20.0,
                                    ),
                                    Text(
                                      'FullName',
                                      style: TextStyle(
                                          fontSize: 12,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    SizedBox(
                                      width: 60,
                                    ),
                                    Text(
                                      '${AgentData.fullname}',
                                      style: TextStyle(
                                          fontWeight: FontWeight.normal,
                                          fontSize: 14),
                                    ),
                                    SizedBox(
                                      height: 10,
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: 20,
                                ),
                                //for gender
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  //mainAxisSize: MainAxisSize.min,

                                  children: <Widget>[
                                    Text(
                                      'Gender',
                                      style: TextStyle(
                                          fontSize: 12,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    SizedBox(
                                      width: 120,
                                    ),
                                    Text(
                                      '${AgentData.gender}',
                                      style: TextStyle(
                                          fontWeight: FontWeight.normal,
                                          fontSize: 14),
                                    ),
                                  ],
                                ),
                                //anoher field
                                SizedBox(
                                  height: 20,
                                ),
                                //for gender
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  //mainAxisSize: MainAxisSize.min,
                                  children: <Widget>[
                                    Text(
                                      'Phone Number',
                                      style: TextStyle(
                                          fontSize: 12,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    SizedBox(
                                      width: 90,
                                    ),
                                    Text(
                                      '${AgentData.phone}',
                                      style: TextStyle(
                                          fontWeight: FontWeight.normal,
                                          fontSize: 14),
                                    ),
                                  ],
                                ),
                                //another field
                                SizedBox(
                                  height: 20,
                                ),
                                //for gender
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  //mainAxisSize: MainAxisSize.min,
                                  children: <Widget>[
                                    Text(
                                      'Comapany Name',
                                      style: TextStyle(
                                          fontSize: 12,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    SizedBox(
                                      width: 20,
                                    ),
                                    Text(
                                      '${AgentData.companyname}',
                                      style: TextStyle(
                                          fontWeight: FontWeight.normal,
                                          fontSize: 13),
                                    ),
                                  ],
                                ),
                                //another field
                                SizedBox(
                                  height: 20,
                                ),
                                //for gender
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  //mainAxisSize: MainAxisSize.min,
                                  children: <Widget>[
                                    Text(
                                      'Company Address',
                                      style: TextStyle(
                                          fontSize: 13,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    SizedBox(
                                      width: 30,
                                    ),
                                    Text(
                                      '${AgentData.companyaddress}',
                                      style: TextStyle(
                                          fontWeight: FontWeight.normal,
                                          fontSize: 13),
                                    ),
                                  ],
                                ),
                              ],
                            ),
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
              color: Colors.orange,
              backgroundColor: Colors.white,
            ),
          );
        },
      ),
    );
  }
}
// late final String fullname;
// late final String gender;
// late final String phone;
// late final String companyname;
// late final String companyaddress;
