import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:estatemanagement/ClientPage/CLogin.dart';
import 'package:estatemanagement/Shared/agentData.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

import '../widgets/widget.dart';

class CRegister extends StatefulWidget {
  const CRegister({Key? key, required this.user}) : super(key: key);
  final User user;
  @override
  State<CRegister> createState() => _CRegisterState();
}

class _CRegisterState extends State<CRegister> {
  var loading = false;
  final _emailcontroller = TextEditingController();
  final passwordcontroller = TextEditingController();
  final fullNameController = TextEditingController();
  final genderController = TextEditingController();
  final phoneController = TextEditingController();
  final AddressController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  final _auth = FirebaseAuth.instance;
  final fireStore = FirebaseFirestore.instance;
  //late final User user;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.orange,
        title: Text('Client Register'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 70),
          child: Center(
            child: Form(
              key: _formKey,
              child: Column(
                children: <Widget>[
                  // Image.asset(
                  //   'assets/estateone.webp',
                  //   width: 150,
                  //   height: 90,
                  // ),
                  CircleAvatar(
                    backgroundImage: AssetImage('assets/estateone.webp'),
                    radius: 50,
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  TextFormField(
                    controller: fullNameController,
                    obscureText: false,
                    decoration: textInputDecoration.copyWith(
                      labelText: 'FullName(s)',
                      prefixIcon: Icon(
                        Icons.location_city_rounded,
                        color: Theme.of(context).primaryColor,
                      ),
                    ),
                    validator: (val) {
                      if (val!.isNotEmpty) {
                        return null;
                      }
                      return "enter valid entry";
                    },
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  TextFormField(
                    controller: genderController,
                    obscureText: false,
                    decoration: textInputDecoration.copyWith(
                      labelText: 'Gender',
                      prefixIcon: Icon(
                        Icons.location_city_rounded,
                        color: Theme.of(context).primaryColor,
                      ),
                    ),
                    validator: (val) {
                      if (val!.isNotEmpty) {
                        return null;
                      }
                      return "enter valid entry";
                    },
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  TextFormField(
                    controller: phoneController,
                    obscureText: false,
                    decoration: textInputDecoration.copyWith(
                      labelText: 'Phone Number',
                      prefixIcon: Icon(
                        Icons.location_city_rounded,
                        color: Theme.of(context).primaryColor,
                      ),
                    ),
                    keyboardType: TextInputType.number,
                    validator: (val) {
                      if (val!.isNotEmpty) {
                        return null;
                      }
                      return "enter valid entry";
                    },
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  TextFormField(
                    controller: AddressController,
                    obscureText: false,
                    decoration: textInputDecoration.copyWith(
                      labelText: 'Home Address',
                      prefixIcon: Icon(
                        Icons.location_city_rounded,
                        color: Theme.of(context).primaryColor,
                      ),
                    ),
                    keyboardType: TextInputType.streetAddress,
                    validator: (val) {
                      if (val!.isNotEmpty) {
                        return null;
                      }
                      return "enter valid entry";
                    },
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  TextFormField(
                    controller: _emailcontroller,
                    obscureText: false,
                    decoration: textInputDecoration.copyWith(
                      labelText: 'email',
                      prefixIcon: Icon(
                        Icons.email,
                        color: Theme.of(context).primaryColor,
                      ),
                    ),
                    keyboardType: TextInputType.emailAddress,
                    validator: (val) {
                      if (val!.isNotEmpty) {
                        return null;
                      }
                      return "enter valid entry";
                    },
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  TextFormField(
                    controller: passwordcontroller,
                    obscureText: false,
                    decoration: textInputDecoration.copyWith(
                      labelText: 'Password',
                      prefixIcon: Icon(
                        Icons.password,
                        color: Theme.of(context).primaryColor,
                      ),
                    ),
                    keyboardType: TextInputType.visiblePassword,
                    validator: (val) {
                      if (val!.isNotEmpty) {
                        return null;
                      }
                      return "enter valid entry";
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
                        child: Text(
                          'Sign Up',
                          style: TextStyle(color: Colors.white, fontSize: 16.0),
                        ),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: (Colors.orange),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30)),
                        ),
                        onPressed: () async {
                          if (_formKey.currentState!.validate()) {
                            //    Register();
                            try {
                              final credential =
                                  await _auth.createUserWithEmailAndPassword(
                                      email: _emailcontroller.text,
                                      password: passwordcontroller.text);
                              final user = credential.user;
                              if (user != null) {
                                clientRegister();
                              }
                            } on FirebaseAuthException catch (e) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(content: Text(e.message ?? '')));
                            }
                          }
                        },
                      ),
                    ),
                  ],
                  SizedBox(
                    height: 15,
                  ),
                  Text.rich(
                    TextSpan(
                      text: 'Already have an account?',
                      style: TextStyle(color: Colors.black, fontSize: 14),
                      children: <TextSpan>[
                        TextSpan(
                            text: "Login now",
                            style: TextStyle(
                                color: Colors.black,
                                decoration: TextDecoration.underline),
                            recognizer: TapGestureRecognizer()
                              ..onTap = () {
                                Navigator.pop(context);
                                nextScreen(
                                    context,
                                    clientLogin(
                                      user: widget.user,
                                    ));
                              }),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future clientRegister() async {
    setState(() {
      loading = true;
    });
    try {
      final client = ClientData(
          //  uid: widget.user.uid,
          fullName: fullNameController.text,
          gender: genderController.text,
          phone: phoneController.text,
          address: AddressController.text,
          email: _emailcontroller.text,
          uid: '');
      await fireStore
          .collection('Clients')
          .doc(client.uid)
          .set(client.toJson());
      await showDialog(
          context: context,
          builder: (context) => AlertDialog(
                title: Text('Clients Data'),
                content: Text('Account was created sucesssfully'),
                actions: [
                  TextButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      child: Text('Okay'))
                ],
              ));
      Navigator.of(context).pop();
      Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => clientLogin(
                user: widget.user,
              )));
    } on FirebaseAuthException catch (e) {
      setState(() {
        loading = false;
      });
    }
  }
}
