import 'package:estatemanagement/ScreenPages/AgentDashboard.dart';
import 'package:estatemanagement/ScreenPages/RegisterPage.dart';
import 'package:estatemanagement/widgets/widget.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

import '../ClientPage/CLogin.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key, required this.user}) : super(key: key);
  final User user;
  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  String email = "";
  String password = "";
  //proper function
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final TextEditingController _emailcontroller = TextEditingController();
  final TextEditingController passwordcontroller = TextEditingController();
  late final User user;
  late bool isPasswordTextField = true;
  bool showPassword = true;
  //end of the variable declearation
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
                  'Login to have access to the system',
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
                  controller: _emailcontroller,
                  decoration: textInputDecoration.copyWith(
                    labelText: 'Email',
                    prefixIcon: Icon(
                      Icons.email,
                      color: Theme.of(context).primaryColor,
                    ),
                  ),
                  onChanged: (val) {
                    setState(() {
                      email = val;
                    });
                  },
                  validator: (val) {
                    if (val == null) {
                      return "email required";
                    }
                    return null;
                  },
                ),
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
                  ),
                  onChanged: (val) {
                    setState(() {
                      password = val;
                    });
                  },
                  validator: (val) {
                    if (val == null) {
                      return "password required";
                    }
                    return null;
                  },
                ),
                SizedBox(
                  height: 10,
                ),
                forgotPassword(context),
                SizedBox(
                  height: 20.0,
                ),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    child: Text(
                      'Sign In',
                      style: TextStyle(color: Colors.white, fontSize: 16.0),
                    ),
                    style: ButtonStyle(
                      backgroundColor:
                          MaterialStateProperty.all<Color>(Colors.orange),
                    ),
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        Login();
                      }
                    },
                  ),
                ),
                SizedBox(
                  height: 15,
                ),
                Text.rich(
                  TextSpan(
                    text: 'Dont have an account?',
                    style: TextStyle(color: Colors.black, fontSize: 14),
                    children: <TextSpan>[
                      TextSpan(
                          text: "Register here",
                          style: TextStyle(
                              color: Colors.black,
                              decoration: TextDecoration.underline),
                          recognizer: TapGestureRecognizer()
                            ..onTap = () {
                              nextScreen(
                                  context,
                                  RegisterPage(
                                    user: widget.user,
                                  ));
                            }),
                    ],
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    TextButton(
                      onPressed: () {
                        setState(() {
                          Navigator.pop(context);
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => clientLogin(
                                        user: widget.user,
                                      )));
                        });
                      },
                      child: Text(
                        'Client Login?',
                        style: TextStyle(color: Colors.green),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Login() async {
    try {
      final UserCredential credential = await _auth.signInWithEmailAndPassword(
          email: _emailcontroller.text, password: passwordcontroller.text);
      Center(
        child: CircularProgressIndicator(
          backgroundColor: Colors.white,
          color: Colors.redAccent,
        ),
      );
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('Login Successfully')));
      final user = credential.user;
      if (user != null) {
        Navigator.of(context).pop();
        Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => AgentDashboard(
                  user: widget.user,
                )));
      }
    } on FirebaseAuthException catch (e) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(e.message ?? '')));
    }
  }

  //forgotten password widget for agent
  Widget forgotPassword(BuildContext context) {
    final resetpasswordcontroller = TextEditingController();
    return Container(
      width: MediaQuery.of(context).size.width,
      height: 35,
      alignment: Alignment.bottomRight,
      child: TextButton(
        child: Text(
          'forgot Password',
          style: TextStyle(
            color: Colors.green,
          ),
          textAlign: TextAlign.right,
        ),
        onPressed: () {
          showDialog(
              context: context,
              builder: (BuildContext context) {
                return AlertDialog(
                  title: Text('Forgotten Password'),
                  content: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      SizedBox(
                        height: 15.0,
                      ),
                      TextField(
                        controller: resetpasswordcontroller,
                        keyboardType: TextInputType.emailAddress,
                        decoration: InputDecoration(
                          hintText: 'enter your emailaddress',
                          hoverColor: Colors.green,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 20.0,
                      ),
                      ElevatedButton(
                        onPressed: () {
                          _auth
                              .sendPasswordResetEmail(
                                  email: resetpasswordcontroller.text)
                              .then((value) => Navigator.of(context).pop());
                        },
                        child: Text('Reset Password'),
                        style: ButtonStyle(
                          textStyle: MaterialStateProperty.all(
                              TextStyle(fontSize: 20.0)),
                          elevation: MaterialStateProperty.all<double>(0.0),
                          backgroundColor:
                              MaterialStateProperty.all<Color>(Colors.orange),
                          //   shadowColor: MaterialStateProperty.all<Color>(Colors.amberAccent),
                          minimumSize: MaterialStateProperty.all(Size(50, 50)),
                          fixedSize: MaterialStateProperty.all(Size(320, 50)),
                          side: MaterialStateProperty.all(
                              BorderSide(color: Colors.orange)),
                        ),
                      ),
                    ],
                  ),
                );
              });
        },
      ),
    );
  }
}
