import 'package:estatemanagement/ScreenPages/AgentReg.dart';
import 'package:estatemanagement/ScreenPages/LoginPage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

import '../widgets/widget.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({Key? key, required this.user}) : super(key: key);
  final User user;
  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final _auth = FirebaseAuth.instance;
  late final User user;
  final _formKey = GlobalKey<FormState>();
  final emailaddress = TextEditingController();
  final passwordcontroller = TextEditingController();
  // String email = "";
  // String password = "";
  // String fullname = "";
  late bool isPasswordTextField = true;
  bool showPassword = true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 70.0),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                SizedBox(
                  height: 50.0,
                ),
                Text(
                  'Real Estate Management SYstem',
                  style: TextStyle(fontSize: 23.0, fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  'Register with your valid email and password',
                  style: TextStyle(
                    fontWeight: FontWeight.w400,
                    fontSize: 15,
                  ),
                ),
                SizedBox(
                  height: 20.0,
                ),
                Image.asset('assets/customeracount.webp'),
                SizedBox(
                  height: 20.0,
                ),
                TextFormField(
                    controller: emailaddress,
                    decoration: textInputDecoration.copyWith(
                      labelText: 'Email',
                      prefixIcon: Icon(
                        Icons.email,
                        color: Theme.of(context).primaryColor,
                      ),
                    ),
                    // onChanged: (val) {
                    //   setState(() {
                    //     email = val;
                    //   });
                    // },
                    validator: (val) {
                      if (val!.isNotEmpty) {
                        return null;
                      } else {
                        return 'Required email';
                      }
                    }),
                SizedBox(
                  height: 15,
                ),
                TextFormField(
                  controller: passwordcontroller,
                  obscureText: true,
                  decoration: textInputDecoration.copyWith(
                    labelText: 'Password',
                    prefixIcon: Icon(
                      Icons.lock,
                      color: Theme.of(context).primaryColor,
                    ),
                    suffixIcon: IconButton(
                      onPressed: () {
                        setState(() {
                          showPassword = !showPassword;
                        });
                      },
                      icon: Icon(Icons.remove_red_eye),
                    ),
                  ),
                  // onChanged: (val) {
                  //   setState(() {
                  //     password = val;
                  //   });
                  // },
                  validator: (val) {
                    if (val!.isNotEmpty) {
                      return null;
                    }
                    return "password required";
                  },
                ),
                SizedBox(
                  height: 20.0,
                ),
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
                                  email: emailaddress.text,
                                  password: passwordcontroller.text);
                          final user = credential.user;
                          if (user != null) {
                            //    CircularProgressIndicator();
                            Navigator.of(context).pop();
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (_) => AgentReg(
                                      user: widget.user,
                                    )));
                          }
                        } on FirebaseAuthException catch (e) {
                          ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text(e.message ?? '')));
                        }
                      }
                    },
                  ),
                ),
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
                                  LoginPage(
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
    );
  }

  // Register() {}
}
