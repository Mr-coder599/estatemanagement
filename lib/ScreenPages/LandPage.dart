import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:estatemanagement/Shared/agentData.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../widgets/AgentDrawer.dart';
import '../widgets/widget.dart';

class LandPage extends StatefulWidget {
  const LandPage({Key? key, required this.user}) : super(key: key);
  final User user;
  @override
  State<LandPage> createState() => _LandPageState();
}

class _LandPageState extends State<LandPage> {
  //controller of all filled
  final fullNameController = TextEditingController();
  final locationController = TextEditingController();
  final AcresController = TextEditingController();
  final AgentController = TextEditingController();
  final priceController = TextEditingController();

  //end of controller
  final fireStore = FirebaseFirestore.instance;
  var loading = false;
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: DrawerAgent(
        user: widget.user,
      ),
      appBar: AppBar(
        backgroundColor: Colors.orangeAccent,
        title: Text('Land Properties'),
        elevation: 0,
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 70),
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.max,
                children: <Widget>[
                  CircleAvatar(
                    backgroundImage: AssetImage('assets/landsales.jpg'),
                    radius: 60,
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  Text(
                    'Please supply neccessary information',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      color: Colors.red,
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  TextFormField(
                    controller: fullNameController,
                    obscureText: false,
                    decoration: textInputDecoration.copyWith(
                      labelText: 'Name of the Owner',
                      prefixIcon: Icon(
                        Icons.person,
                        color: Theme.of(context).primaryColor,
                      ),
                    ),
                    validator: (val) {
                      if (val!.isNotEmpty) {
                        return null;
                      }
                      return "required data";
                    },
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  TextFormField(
                    controller: locationController,
                    obscureText: false,
                    decoration: textInputDecoration.copyWith(
                      labelText: 'Location/Address',
                      prefixIcon: Icon(
                        Icons.location_city_rounded,
                        color: Theme.of(context).primaryColor,
                      ),
                    ),
                    validator: (val) {
                      if (val!.isNotEmpty) {
                        return null;
                      }
                      return "required Address";
                    },
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  TextFormField(
                    controller: AcresController,
                    obscureText: false,
                    decoration: textInputDecoration.copyWith(
                      labelText: 'Number of Arcer',
                      prefixIcon: Icon(
                        Icons.landscape,
                        color: Theme.of(context).primaryColor,
                      ),
                    ),
                    validator: (val) {
                      if (val!.isNotEmpty) {
                        return null;
                      }
                      return "required number of Acres";
                    },
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  TextFormField(
                    controller: priceController,
                    obscureText: false,
                    decoration: textInputDecoration.copyWith(
                      labelText: 'Price of the land',
                      prefixIcon: Icon(
                        Icons.money,
                        color: Theme.of(context).primaryColor,
                      ),
                    ),
                    keyboardType: TextInputType.phone,
                    validator: (val) {
                      if (val!.isNotEmpty) {
                        return null;
                      }
                      return "required name of the hostel";
                    },
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  TextFormField(
                    controller: AgentController,
                    decoration: textInputDecoration.copyWith(
                      labelText: 'Agent In charge',
                      prefixIcon: Icon(
                        Icons.person,
                        color: Theme.of(context).primaryColor,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  if (loading) ...[
                    Center(child: CircularProgressIndicator()),
                  ],
                  if (!loading) ...[
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () async {
                          if (_formKey.currentState != null) {
                            if (_formKey.currentState!.validate()) {
                              try {
                                final land = LandData(
                                  uid: widget.user.uid,
                                  ownerName: fullNameController.text,
                                  location: locationController.text,
                                  agentName: AgentController.text,
                                  Nacres: AcresController.text,
                                  price: priceController.text,
                                );
                                await fireStore
                                    .collection('Landsales')
                                    .doc(land.uid)
                                    .set(land.toJson());
                                Center(
                                  child: CircularProgressIndicator(),
                                );
                                ScaffoldMessenger.of(context)
                                    .showSnackBar(SnackBar(
                                        content: Text(
                                  'Land Properties updated Successfylly',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                  ),
                                )));
                                clear();
                              } on FirebaseException catch (e) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(content: Text(e.message ?? '')));
                              }
                              // RentalDataSaved();
                            }
                          }
                        },
                        child: Text(
                          'Save Data',
                          style: TextStyle(color: Colors.white, fontSize: 16),
                        ),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.orange,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30)),
                        ),
                      ),
                    ),
                  ],
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  clear() {
    fullNameController.clear();
    locationController.clear();
    AgentController.clear();
    priceController.clear();
    AcresController.clear();
  }
}
