import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:estatemanagement/widgets/AgentDrawer.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../Shared/agentData.dart';
import '../widgets/widget.dart';

class RentalPage extends StatefulWidget {
  const RentalPage({Key? key, required this.user}) : super(key: key);
  final User user;
  @override
  State<RentalPage> createState() => _RentalPageState();
}

class _RentalPageState extends State<RentalPage> {
  var loading = false;
  String dropdownvalue = 'Single Room';
  var items = [
    'Single Room',
    'SelfCon',
    'Room and Parlor',
    'Duplex',
    'Bongal'
        'ow'
  ];
  final _formKey = GlobalKey<FormState>();
  final houseController = TextEditingController();
  final locationController = TextEditingController();
  final typeHouseController = TextEditingController();
  final amountController = TextEditingController();
  final DescriptionController = TextEditingController();
  final statusController = TextEditingController();
  final firestore = FirebaseFirestore.instance;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: DrawerAgent(
        user: widget.user,
      ),
      appBar: AppBar(
        backgroundColor: Colors.orange,
        title: Text('Rental Page'),
        elevation: 0,
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 70),
          child: Center(
            child: Form(
              key: _formKey,
              child: Column(
                children: <Widget>[
                  CircleAvatar(
                    backgroundImage: AssetImage(
                        'assets/Houseplan-6-bedroom-1-1024x652.webp'),
                    radius: 60,
                  ),
                  // Image.asset('assets/Houseplan-6-bedroom-1-1024x652.webp'),
                  SizedBox(
                    height: 20.0,
                  ),
                  Text(
                    'Update the available house with different '
                    'location',
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 15,
                        color: Colors.red),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  TextFormField(
                    controller: houseController,
                    obscureText: false,
                    decoration: textInputDecoration.copyWith(
                      labelText: 'Name of the hostel or house',
                      prefixIcon: Icon(
                        Icons.house,
                        color: Theme.of(context).primaryColor,
                      ),
                    ),
                    validator: (val) {
                      if (val!.isNotEmpty) {
                        return null;
                      }
                      return "required name of the hostel";
                    },
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  TextFormField(
                    controller: locationController,
                    obscureText: false,
                    decoration: textInputDecoration.copyWith(
                      labelText: 'Location',
                      prefixIcon: Icon(
                        Icons.location_on,
                        color: Theme.of(context).primaryColor,
                      ),
                    ),
                    validator: (val) {
                      if (val!.isNotEmpty) {
                        return null;
                      }
                      return "location required";
                    },
                  ),
                  SizedBox(height: 15.0),
                  // Padding(padding: EdgeInsets.()),
                  DropdownButton(
                      isExpanded: true,
                      hint: Text('Select type '),
                      value: dropdownvalue,
                      icon: Icon(Icons.keyboard_arrow_down),
                      style: TextStyle(
                          color: Colors.orange,
                          fontSize: 16,
                          fontWeight: FontWeight.bold),
                      items: items.map((String items) {
                        return DropdownMenuItem(
                          value: items,
                          child: Text(items),
                        );
                      }).toList(),
                      onChanged: (String? newValue) {
                        setState(() {
                          dropdownvalue = newValue!;
                          typeHouseController.text = newValue;
                        });
                      }),
                  SizedBox(
                    height: 15,
                  ),
                  TextFormField(
                    controller: amountController,
                    obscureText: false,
                    decoration: textInputDecoration.copyWith(
                      labelText: '#Amount',
                      prefixIcon: Icon(
                        Icons.money,
                        color: Theme.of(context).primaryColor,
                      ),
                    ),
                    validator: (val) {
                      if (val!.isNotEmpty) {
                        return null;
                      }
                      return "Amount required";
                    },
                  ),
                  SizedBox(
                    height: 15.0,
                  ),
                  SizedBox(
                    width: 350,
                    child: TextFormField(
                      controller: DescriptionController,
                      //validator: _requiredValidator,
                      decoration: textInputDecoration.copyWith(
                        contentPadding: EdgeInsets.all(10),
                        border: OutlineInputBorder(),
                        labelText: 'Description of message about the house',
                      ),
                      style: TextStyle(
                        fontSize: 20,
                      ),
                      maxLines: null,
                      minLines: null,
                    ),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  TextFormField(
                    controller: statusController,
                    obscureText: false,
                    decoration: textInputDecoration.copyWith(
                      labelText: 'Status e.g Available or Paid',
                      prefixIcon: Icon(
                        Icons.signal_wifi_statusbar_4_bar,
                        color: Theme.of(context).primaryColor,
                      ),
                    ),
                    validator: (val) {
                      if (val!.isNotEmpty) {
                        return null;
                      }
                      return "Field required";
                    },
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
                        onPressed: () {
                          if (_formKey.currentState != null) {
                            if (_formKey.currentState!.validate()) {
                              RentalDataSaved();
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

  Future RentalDataSaved() async {
    setState(() {
      loading = true;
    });
    try {
      final RentsData = RentData(
        uid: widget.user.uid,
        hostelname: houseController.text,
        location: locationController.text,
        typehouse: typeHouseController.text,
        amount: amountController.text,
        description: DescriptionController.text,
        status: statusController.text,
      );

      await firestore
          .collection('Rental')
          .doc(RentsData.uid)
          .set(RentsData.toJson());
      await showDialog(
          context: context,
          builder: (context) => AlertDialog(
                title: Text('House Data'),
                content: Text('House was Updated'),
                actions: [
                  TextButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      child: Text('Ok')),
                ],
              ));
      typeHouseController.clear();
      amountController.clear();
      houseController.clear();
      locationController.clear();
      DescriptionController.clear();
      statusController.clear();
      // Navigator.of(context).pop();
      // Navigator.of(context).pushReplacement(MaterialPageRoute(
      //     builder: (context) => AgentDashboard(user: widget.user)));
    } on FirebaseAuthException catch (e) {
      _handleSignupError(e);
      setState(() {
        loading = false;
      });
    }
  }

  void _handleSignupError(FirebaseAuthException e) {
    String? messageToDisplay;
    switch (e.code) {
      case 'email already in use':
        messageToDisplay = "This email is already in use";
        break;
      case 'invalid email':
        messageToDisplay = "This email you entered is invalid";
        break;
      case 'operation not allowed':
        messageToDisplay = "The operation not allowed";
        break;
    }
    showDialog(
        context: context,
        builder: (context) => AlertDialog(
              title: Text(''),
              content: Text('Registration not Successfull'),
              actions: [
                TextButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: Text('Ok'))
              ],
            ));
  }
}
