import 'package:estatemanagement/ClientPage/cRegister.dart';
import 'package:estatemanagement/widgets/widget.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

import 'cProfile.dart';

class clientLogin extends StatefulWidget {
  const clientLogin(
      {Key? key,
      //  User? user,
      required this.user})
      : super(key: key);
  final User user;
  @override
  State<clientLogin> createState() => _CloginPageState();
}

class _CloginPageState extends State<clientLogin> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final TextEditingController _emailcontroller = TextEditingController();
  final TextEditingController passwordcontroller = TextEditingController();
  //late final User user;
  String email = '';
  String password = '';
  late bool isPasswordTextField = true;
  bool showPassword = true;
  final _form = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Client Login'),
        elevation: 1,
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 70),
            child: Form(
              key: _form,
              child: Column(
                children: <Widget>[
                  SizedBox(
                    height: 20,
                  ),
                  Text(
                    'Supply Your Login Credentials',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.blue,
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Image.asset("assets/HL_M65_01.jpg"),
                  SizedBox(
                    height: 30,
                  ),
                  TextFormField(
                      controller: _emailcontroller,
                      decoration: textInputDecoration.copyWith(
                        labelText: 'Email',
                        prefixIcon: Icon(Icons.email),
                      ),
                      style: TextStyle(fontSize: 14),
                      keyboardType: TextInputType.emailAddress,
                      validator: (val) =>
                          val!.isEmpty ? 'Required email Address' : null,
                      onChanged: (val) {
                        setState(() => email = val);
                      }),
                  SizedBox(
                    height: 30,
                  ),
                  TextFormField(
                      controller: passwordcontroller,
                      obscureText: isPasswordTextField ? showPassword : true,
                      decoration: textInputDecoration.copyWith(
                          labelText: 'Password',
                          prefixIcon: Icon(Icons.password),
                          suffixIcon: IconButton(
                            onPressed: () {
                              setState(() {
                                showPassword = !showPassword;
                              });
                            },
                            icon: Icon(Icons.remove_red_eye),
                          )),
                      onChanged: (val) {
                        setState(() => password = val);
                      }),
                  SizedBox(
                    height: 20,
                  ),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      child: Text(
                        'Login',
                        style: TextStyle(color: Colors.white, fontSize: 16.0),
                      ),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: (Colors.orange),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30)),
                      ),
                      onPressed: () async {
                        if (_form.currentState!.validate()) {
                          Login();
                          //    Register();
                          // try {
                          //   final credential =
                          //       await _auth.createUserWithEmailAndPassword(
                          //           email: _emailcontroller.text,
                          //           password: passwordcontroller.text);
                          //   final user = credential.user;
                          //   if (user != null) {
                          //     //    CircularProgressIndicator();
                          //     // Navigator.of(context).pop();
                          //     // Navigator.of(context).push(MaterialPageRoute(
                          //     //     builder: (_) => AgentReg(
                          //     //           user: user,
                          //     //         )));
                          //   }
                          // } on FirebaseAuthException catch (e) {
                          //   ScaffoldMessenger.of(context).showSnackBar(
                          //       SnackBar(content: Text(e.message ?? '')));
                          // }
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
                            text: "Register now",
                            style: TextStyle(
                                color: Colors.black,
                                decoration: TextDecoration.underline),
                            recognizer: TapGestureRecognizer()
                              ..onTap = () {
                                Navigator.pop(context);
                                nextScreen(
                                    context, CRegister(user: widget.user));
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
            builder: (context) => CProfile(
                  user: widget.user,
                )));
      }
    } on FirebaseAuthException catch (e) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(e.message ?? '')));
    }
  }
}
