import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sky_note/home.dart';
import 'package:sky_note/login.dart';
import 'package:sky_note/utils/colors.dart';

class Sign extends StatefulWidget {
  const Sign({super.key});

  @override
  State<Sign> createState() => _SignState();
}

class _SignState extends State<Sign> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController _email = TextEditingController();
  TextEditingController _pword = TextEditingController();
  TextEditingController _fname = TextEditingController();
  bool isOpen = true, _startloading = false;
  final db = FirebaseFirestore.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
      child: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Padding(
            padding: const EdgeInsets.all(15.0),
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
                          Text("Sign Up",
                              style: GoogleFonts.poppins(
                                textStyle: TextStyle(
                                    color: AppColor.txt,
                                    fontWeight: FontWeight.w600,
                                    fontSize: 24),
                              )),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 50,
                    ),
                    Text(
                      "Fullname",
                      style: GoogleFonts.poppins(
                          textStyle: TextStyle(
                              fontWeight: FontWeight.w500,
                              color: AppColor.txt)),
                    ),
                    TextFormField(
                      controller: _fname,
                      keyboardType: TextInputType.name,
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      validator: (value) {
                        if (value!.length < 6) {
                          return "Enter full name";
                        } else {
                          return null;
                        }
                      },
                    ),
                    const SizedBox(
                      height: 20,
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
                    const SizedBox(
                      height: 30,
                    ),
                    Center(
                      child: _startloading
                          ? const CircularProgressIndicator()
                          : SizedBox(
                              width: 440,
                              height: 40,
                              child: MaterialButton(
                                onPressed: () {
                                  if (_formKey.currentState!.validate()) {
                                    handleRegister(_email.text, _pword.text);
                                    //   Navigator.pushNamed(context, '/login');
                                  }
                                },
                                color: AppColor.primary,
                                height: 50,
                                minWidth: 360,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10)),
                                child: Text(
                                  "Sign up",
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
                    //      Navigator.pushReplacementNamed(context, "/login");
                    //     }
                    //   },
                    //   color: AppColor.primary,
                    //   height: 50,
                    //   minWidth: 360,
                    //   shape: RoundedRectangleBorder(
                    //       borderRadius: BorderRadius.circular(10)),
                    //   child: Text(
                    //     "Sign up",
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
                          GestureDetector(
                            child: Container(
                                height: 33,
                                width: 56,
                                decoration: BoxDecoration(
                                    color: const Color(0XFFF1F1F1),
                                    borderRadius: BorderRadius.circular(20),
                                    boxShadow: const [
                                      BoxShadow(
                                          color: Color(0XFFF1F1F1),
                                          spreadRadius: 1,
                                          blurRadius: 20.0)
                                    ]),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Image.asset("assets/google.png"),
                                  ],
                                )),
                          ),
                          const SizedBox(
                            width: 15,
                          ),
                          GestureDetector(
                            child: Container(
                                height: 33,
                                width: 56,
                                decoration: BoxDecoration(
                                    color: const Color(0XFFF1F1F1),
                                    borderRadius: BorderRadius.circular(20),
                                    boxShadow: const [
                                      BoxShadow(
                                          color: Color(0XFFF1F1F1),
                                          spreadRadius: 1,
                                          blurRadius: 20.0)
                                    ]),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Image.asset("assets/apple.png"),
                                  ],
                                )),
                          ),
                          const SizedBox(
                            width: 15,
                          ),
                          GestureDetector(
                            child: Container(
                                height: 33,
                                width: 56,
                                decoration: BoxDecoration(
                                    color: const Color(0XFFF1F1F1),
                                    borderRadius: BorderRadius.circular(20),
                                    boxShadow: const [
                                      BoxShadow(
                                          color: Color(0XFFF1F1F1),
                                          spreadRadius: 1,
                                          blurRadius: 20.0)
                                    ]),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Image.asset("assets/facebook.png"),
                                  ],
                                )),
                          )
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    Center(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "Already a user?",
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
                                      builder: (context) => const LoginPage()));
                            },
                            child: Text(
                              "Sign In",
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
    ));
  }

  Future<void> handleRegister(String email, String password) async {
    startLoading();
    try {
      await FirebaseAuth.instance
          .createUserWithEmailAndPassword(
              email: email.trim(), password: password)
          .then((value) async {
        try {
          await db.collection("users").doc(value.user!.uid).set({
            "uid": value.user!.uid,
            "email": _email.text,
            "fullname": _fname.text,
            'notes': [],
            "date_created": DateTime.now().toString(),
          }).then((v) {
            stopLoading();
            snackBar('Registration successful.');
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => const MyHomePage(),
              ),
            );
          });
        } catch (e) {
          snackBar(e.toString());
        }
      });
    } on FirebaseAuthException catch (e) {
      stopLoading();
      if (e.code == 'weak-password') {
        snackBar('The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        snackBar('The account already exists for that email.');
      }
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
    _fname = TextEditingController();
    _email = TextEditingController();
    _pword = TextEditingController();

    super.initState();
  }

  @override
  void dispose() {
    _fname.dispose();
    _email.dispose();
    _pword.dispose();

    super.dispose();
  }
}
