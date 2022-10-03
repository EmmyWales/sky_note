import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sky_note/sign_up.dart';
import 'package:sky_note/utils/colors.dart';
import 'dart:async';

import 'home.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();

  TextEditingController _email = TextEditingController();
  TextEditingController _pword = TextEditingController();
  bool isOpen = true, _startloading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: WillPopScope(
        onWillPop: () async => false,
        child: SafeArea(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Form(
                key: _formKey,
                child: Stack(
                  children: [
                    const SafeArea(
                      child: Image(image: AssetImage("assets/backdrop.png")),
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Center(
                          child: Column(
                            children: [
                              const SizedBox(
                                height: 150,
                              ),
                              Image.asset(
                                "assets/skynote.png",
                              ),
                              const SizedBox(height: 20),
                              Text("Welcome Back",
                                  style: GoogleFonts.poppins(
                                    textStyle: TextStyle(
                                        color: AppColor.txt,
                                        fontWeight: FontWeight.w600,
                                        fontSize: 24),
                                  )),
                              const SizedBox(
                                height: 10,
                              ),
                              Text(
                                "Sign in to continue",
                                style: GoogleFonts.poppins(
                                    textStyle: const TextStyle(
                                        fontWeight: FontWeight.w400,
                                        fontSize: 14)),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(
                          height: 50,
                        ),
                        Text(
                          "Email",
                          style: GoogleFonts.poppins(
                              textStyle: TextStyle(
                                  fontWeight: FontWeight.w500,
                                  color: AppColor.txt)),
                        ),
                        TextFormField(
                          controller: _email,
                          keyboardType: TextInputType.emailAddress,
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          validator: (value) {
                            if (value!.length < 8) {
                              return "Enter a valid email";
                            } else if (!value.contains('@')) {
                              return "Email must contain '@'";
                            } else if (!value.contains('.com')) {
                              return "Email must contain .com";
                            } else {
                              return null;
                            }
                          },
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Text(
                          "Password",
                          style: GoogleFonts.poppins(
                              textStyle: TextStyle(
                                  fontWeight: FontWeight.w500,
                                  color: AppColor.txt)),
                        ),
                        TextFormField(
                          controller: _pword,
                          keyboardType: TextInputType.text,
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          obscureText: true,
                          validator: (value) {
                            if (value!.length < 8) {
                              return "Password must not be less than 8 caracters ";
                            } else {
                              return null;
                            }
                          },
                        ),
                        Align(
                          alignment: Alignment.centerRight,
                          child: TextButton(
                              onPressed: (() {
                                Navigator.pushNamed(context, "/fpassword");
                              }),
                              child: Text("Forgot Password?",
                                  style: GoogleFonts.poppins(
                                    textStyle: const TextStyle(
                                        fontWeight: FontWeight.w400,
                                        fontSize: 12,
                                        color: Color.fromARGB(255, 93, 89, 89)),
                                  ))),
                        ),
                        const SizedBox(
                          height: 30,
                        ),
                        Center(
                          child: _startloading
                              ? const CircularProgressIndicator()
                              : SizedBox(
                                  height: 50,
                                  width: 360,
                                  child: MaterialButton(
                                    onPressed: () {
                                      if (_formKey.currentState!.validate()) {
                                        handleLogin(_email.text, _pword.text);
                                      }
                                    },
                                    color: AppColor.primary,
                                    shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(10)),
                                    child: Text(
                                      "Login",
                                      style: GoogleFonts.poppins(
                                          textStyle: const TextStyle(
                                              fontWeight: FontWeight.w500,
                                              color: Color(0XFFFFFFFF))),
                                    ),
                                  ),
                                ),
                        ),
                        // MaterialButton(
                        //   onPressed: () {
                        //     if (_formKey.currentState!.validate()) {
                        //       Navigator.pushReplacementNamed(context, '/home');
                        //     }
                        //   },
                        //   color: AppColor.primary,
                        //   height: 50,
                        //   minWidth: 360,
                        //   shape: RoundedRectangleBorder(
                        //       borderRadius: BorderRadius.circular(10)),
                        //   child: Text(
                        //     "Login",
                        //     style: GoogleFonts.poppins(
                        //         textStyle: const TextStyle(
                        //             fontWeight: FontWeight.w500,
                        //             color: Color(0XFFFFFFFF))),
                        //   ),
                        // ),
                        const SizedBox(
                          height: 30,
                        ),
                        Center(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                "New user?",
                                style: GoogleFonts.poppins(
                                  textStyle: const TextStyle(
                                      fontWeight: FontWeight.w400,
                                      fontSize: 14,
                                      color: Color.fromARGB(255, 93, 89, 89)),
                                ),
                              ),
                              TextButton(
                                onPressed: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => const Sign()));
                                },
                                child: Text(
                                  "Sign Up",
                                  style: GoogleFonts.poppins(
                                    textStyle: TextStyle(
                                      fontWeight: FontWeight.w600,
                                      fontSize: 14,
                                      color: AppColor.primary,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
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
    );
    
  }

  Future<void> handleLogin(String email, String password) async {
    startLoading();
    try {
      await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password)
          .then((value) async {
        stopLoading();
        snackBar('Login successful.');
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => const MyHomePage(),
          ),
        );
      });
    } on FirebaseAuthException catch (e) {
      stopLoading();
      if (e.code == 'user-not-found') {
        snackBar('No user found for that email.');
      } else if (e.code == 'wrong-password') {
        snackBar('Wrong password provided for that user.');
      }
    } on TimeoutException catch (_) {
      stopLoading();
      snackBar('timeMsg');
    } catch (e) {
      stopLoading();
      snackBar(e.toString());
    }
  }

  void startLoading() {
    setState(() => _startloading = true);
  }

  void stopLoading() {
    setState(() => _startloading = false);
  }

  snackBar(String title) {
    return ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(title),
      ),
    );
  }

  @override
  void initState() {
    _email = TextEditingController();
    _pword = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _email.dispose();
    _pword.dispose();
    super.dispose();
  }
}
