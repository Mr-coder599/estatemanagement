import 'dart:core';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:estatemanagement/ScreenPages/LoginPage.dart';
import 'package:estatemanagement/Shared/agentData.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../widgets/widget.dart';

class AgentReg extends StatefulWidget {
  const AgentReg({Key? key, required this.user}) : super(key: key);
  final User user;
  @override
  State<AgentReg> createState() => _AgentRegState();
}

class _AgentRegState extends State<AgentReg> {
  final _formKey = GlobalKey<FormState>();
  //decleare controller fr each field

  final _fullnameController = TextEditingController();
  final _genderController = TextEditingController();
  final _phoneController = TextEditingController();
  final _companynameController = TextEditingController();
  final _companyaddressController = TextEditingController();
  //end of controller
//local variable for all field
  String fullname = "";
  String gender = "";
  String phone = "";
  //String address = "";
  String companyname = "";
  String companyaddress = "";
  //end of local varialble for all field
  var loading = false;
  final firestore = FirebaseFirestore.instance;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Agent Registration'),
        elevation: 0,
        backgroundColor: Colors.orange,
      ),
      body: SingleChildScrollView(
        child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 70),
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Text(
                    'Please supply the neccessary information below',
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 15,
                        color: Colors.orange),
                  ),
                  SizedBox(height: 20),
                  CircleAvatar(
                    backgroundImage:
                        AssetImage('assets/FeatureImage_real_estate_words.jpg'),
                    radius: 60,
                  ),
                  SizedBox(height: 20),
                  TextFormField(
                    controller: _fullnameController,
                    decoration: textInputDecoration.copyWith(
                      labelText: 'FullName(s)',
                      prefixIcon: Icon(
                        Icons.person,
                        color: Theme.of(context).primaryColor,
                      ),
                    ),
                    onChanged: (val) {
                      setState(() {
                        fullname = val;
                      });
                    },
                    validator: _requiredValidator,
                    //     (val) {
                    //   if (val!.isNotEmpty) {
                    //     return null;
                    //   } else {
                    //     return "fullName cannot be empty";
                    //   }
                    // }
                  ),
                  SizedBox(height: 15),
                  TextFormField(
                    controller: _genderController,
                    decoration: textInputDecoration.copyWith(
                      labelText: 'Gender',
                      prefixIcon: Icon(
                        Icons.transgender,
                        color: Theme.of(context).primaryColor,
                      ),
                    ),
                    onChanged: (val) {
                      setState(() {
                        gender = val;
                      });
                    },
                    validator: _requiredValidator,
                    //     (val) {
                    //   if (val!.isNotEmpty) {
                    //     return null;
                    //   } else {
                    //     return 'Required supply gender';
                    //   }
                    // }
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  TextFormField(
                    // obscureText: true,
                    controller: _phoneController,
                    decoration: textInputDecoration.copyWith(
                      labelText: 'Phone Number',
                      prefixIcon: Icon(
                        Icons.phone,
                        color: Theme.of(context).primaryColor,
                      ),
                    ),
                    onChanged: (val) {
                      setState(() {
                        phone = val;
                      });
                    },
                    validator: _requiredValidator,
                    keyboardType: TextInputType.phone,
                    //     (val) {
                    //   if (val == null) {
                    //     return "required supply phone number";
                    //   }
                    //   return null;
                    // },
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  TextFormField(
                    controller: _companynameController,
                    // obscureText: true,
                    decoration: textInputDecoration.copyWith(
                      labelText: 'Company Name',
                      prefixIcon: Icon(
                        Icons.add_reaction,
                        color: Theme.of(context).primaryColor,
                      ),
                    ),
                    onChanged: (val) {
                      setState(() {
                        companyname = val;
                      });
                    },
                    validator: _requiredValidator,
                    //     (val) {
                    //   if (val == null) {
                    //     return "required supply phone number";
                    //   }
                    //   return null;
                    // },
                    keyboardType: TextInputType.streetAddress,
                  ),
                  SizedBox(height: 15),
                  SizedBox(
                    width: 350,
                    child: TextFormField(
                      controller: _companyaddressController,
                      validator: _requiredValidator,
                      decoration: textInputDecoration.copyWith(
                        contentPadding: EdgeInsets.all(10),
                        border: OutlineInputBorder(),
                        labelText: 'Company Address',
                        prefixIcon: Icon(
                          Icons.location_on,
                          color: Theme.of(context).primaryColor,
                        ),
                      ),
                      style: TextStyle(
                        fontSize: 20,
                      ),
                      maxLines: null,
                      minLines: null,
                      keyboardType: TextInputType.streetAddress,
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  SizedBox(
                    height: 15.0,
                  ),
                  if (loading) ...[
                    Center(child: CircularProgressIndicator()),
                  ],
                  if (!loading) ...[
                    ElevatedButton(
                      onPressed: () {
                        if (_formKey.currentState != null) {
                          if (_formKey.currentState!.validate()) {
                            AgentSaveData();
                          }
                        }
                      },
                      child: Text(
                        'Register',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 20.0,
                          color: Colors.white,
                        ),
                      ),
                      style: ButtonStyle(
                        textStyle: MaterialStateProperty.all(
                            TextStyle(fontSize: 20.0)),
                        elevation: MaterialStateProperty.all<double>(0.0),
                        backgroundColor:
                            MaterialStateProperty.all<Color>(Colors.orange),
                        //   shadowColor: MaterialStateProperty.all<Color>(Colors.amberAccent),
                        minimumSize: MaterialStateProperty.all(Size(50, 50)),
                        fixedSize: MaterialStateProperty.all(Size(320, 50)),
                        side: MaterialStateProperty.all(BorderSide(
                          color: Colors.white,
                        )),
                        shape: MaterialStateProperty.all(RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30))),
                      ),
                    ),
                  ],
                ],
              ),
            )),
      ),
    );
  }

  String? _requiredValidator(String? text) {
    if (text == null || text.trim().isEmpty) {
      return "This field is required";
    }
    return null;
  }

  Future AgentSaveData() async {
    setState(() {
      loading = true;
    });
    try {
      final agents = AgentInfo(
        uid: widget.user.uid,
        fullname: _fullnameController.text,
        gender: _genderController.text,
        phone: _phoneController.text,
        companyname: _companynameController.text,
        companyaddress: _companyaddressController.text,
      );
      await firestore.collection('Agent').doc(agents.uid).set(agents.toJson());
      await showDialog(
          context: context,
          builder: (context) => AlertDialog(
                title: Text('Saving Data'),
                content: Text('Account was creaed, Procced to login'),
                actions: [
                  TextButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      child: Text('Ok')),
                ],
              ));
      Navigator.of(context).pop();
      Navigator.of(context).pushReplacement(MaterialPageRoute(
          builder: (context) => LoginPage(
                user: widget.user,
              )));
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
