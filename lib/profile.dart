import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sky_note/utils/colors.dart';

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  User? user = FirebaseAuth.instance.currentUser;
  final db = FirebaseFirestore.instance;
  String name = '', email = '';
  TextEditingController? _fname, _email;

  @override
  Widget build(BuildContext context) {
    final docRef = db.collection("users").doc(user!.uid);
    docRef.get().then(
      (DocumentSnapshot doc) {
        final data = doc.data() as Map<String, dynamic>;
        name = data['fullname'];
        email = data['email'];
        _fname = TextEditingController(text: data['fullname']);
        _email = TextEditingController(text: data['email']);
      },
      // ignore: avoid_print
      onError: (e) => print("Error getting document: $e"),
    );
    return StreamBuilder(
        stream: db.collection("users").doc(user!.uid).snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Scaffold(
                body: Center(child: CircularProgressIndicator()));
          } else if (snapshot.connectionState == ConnectionState.active) {
            // List newNote = List.from(snapshot.data!['notes'].reversed);
            // var spiltname = snapshot.data!['fullname'].split(' ');
            return Scaffold(
              appBar: AppBar(
                automaticallyImplyLeading: true,
                title: Text(
                  "Profile",
                  style: GoogleFonts.poppins(
                      textStyle: TextStyle(
                          fontWeight: FontWeight.w500, color: AppColor.txt),
                      fontSize: 18),
                ),
                centerTitle: true,
                backgroundColor: Colors.transparent,
                elevation: 0,
                foregroundColor: AppColor.txt,
              ),
              bottomNavigationBar: GestureDetector(
                onTap: (() => FirebaseAuth.instance.signOut().then(
                      (value) {
                        Navigator.pushReplacementNamed(context, '/login');
                      },
                    )),
                child: Container(
                    height: 60,
                    width: MediaQuery.of(context).size.width,
                    color: AppColor.primary,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Log Out",
                          style: GoogleFonts.poppins(
                            textStyle: const TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w500,
                                fontSize: 13),
                          ),
                        ),
                        const SizedBox(
                          width: 20,
                        ),
                        const Icon(
                          Icons.logout,
                          color: Colors.white,
                          size: 13,
                        )
                      ],
                    )),
              ),
              body: SingleChildScrollView(
                child: SafeArea(
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Stack(
                      children: [
                        const Image(image: AssetImage("assets/Frame.png")),
                        Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Center(
                                child: CircleAvatar(
                                    backgroundColor: AppColor.primary,
                                    radius: 40,
                                    child: const Icon(
                                      Icons.person,
                                      color: Colors.white,
                                    )),
                              ),
                              const SizedBox(height: 30),
                              Text(
                                "Full Name",
                                style: GoogleFonts.nunito(
                                  textStyle: const TextStyle(
                                      color: Color(0XFF083A50),
                                      fontWeight: FontWeight.w700,
                                      fontSize: 14),
                                ),
                              ),
                              const SizedBox(height: 10),
                              TextField(
                                controller: _fname,
                                decoration: InputDecoration(
                                    labelText: (name),
                                    suffix: const Icon(
                                      Icons.edit,
                                      size: 13,
                                    ),
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10),
                                    )),
                              ),
                              const SizedBox(
                                height: 30,
                              ),
                              Text(
                                "Email",
                                style: GoogleFonts.nunito(
                                  textStyle: const TextStyle(
                                      color: Color(0XFF083A50),
                                      fontWeight: FontWeight.w700,
                                      fontSize: 14),
                                ),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              TextField(
                                controller: _email,
                                decoration: InputDecoration(
                                  labelText: (email),
                                  suffix: const Icon(
                                    Icons.edit,
                                    size: 13,
                                  ),
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10)),
                                ),
                              ),
                              const SizedBox(height: 30),
                              // ValueListenableBuilder(
                              //     valueListenable:
                              //         Hive.box('dark mode').listenable(),
                              //     builder: (context, Box box, child) {
                              //       bool getValue = box.get('dark mode',
                              //           defaultValue: true);

                              //       return Row(
                              //         mainAxisAlignment:
                              //             MainAxisAlignment.spaceBetween,
                              //         children: [
                              //           Text(
                              //             "Select Mode",
                              //             style: GoogleFonts.nunito(
                              //               textStyle: const TextStyle(
                              //                   color: Color(0XFF083A50),
                              //                   fontWeight: FontWeight.w700,
                              //                   fontSize: 14),
                              //             ),
                              //           ),
                              // Switch(
                              //   activeColor: AppColor.primary,
                              //   value: getValue,
                              //   onChanged: (value) {
                              //     box.put('dark mode', !getValue);
                              //   },
                              // ),
                              //     ],
                              //   );
                              // }),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            );
          } else {
            return Center(
                child: Text(
                    'Something went wrong ${snapshot.data!} / ${snapshot.connectionState}'));
          }
        });
  }
}
