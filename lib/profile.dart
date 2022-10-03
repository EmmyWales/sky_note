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
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: true,
        title: Text(
          "Profile",
          style: GoogleFonts.poppins(
              textStyle:
                  TextStyle(fontWeight: FontWeight.w500, color: AppColor.txt),
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
                },)
              ),
        child: Container(
            height: 80,
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
                  padding: const EdgeInsets.all(15.0),
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
                      const SizedBox(
                        height: 30,
                      ),
                      Text(
                        "Full Name",
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
                        decoration: InputDecoration(
                            suffix: const Icon(
                              Icons.edit,
                              size: 13,
                            ),
                            border: OutlineInputBorder(
                               borderRadius: BorderRadius.circular(10),
                            )

                            // focusedBorder: OutlineInputBorder(
                            //     borderRadius: BorderRadius.circular(10),
                            //     borderSide:
                            //         const BorderSide( color: Color(0XFFCACED8), width: 3)),
                            // enabledBorder: UnderlineInputBorder(
                            //     borderRadius: BorderRadius.circular(10),
                            //     borderSide:
                            //         const BorderSide(color: Color(0XFFCACED8), width: 3)),
                            ),
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
                        decoration: InputDecoration(
                          suffix: const Icon(
                            Icons.edit,
                            size: 13,
                          ),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10)),
                          // focusedBorder: OutlineInputBorder(
                          //     borderRadius: BorderRadius.circular(10),
                          //     borderSide:
                          //         const BorderSide(color: Color(0XFFCACED8))),
                          // enabledBorder: UnderlineInputBorder(
                          //     borderRadius: BorderRadius.circular(10),
                          //     borderSide:
                          //         const BorderSide(color: Color(0XFFCACED8))),
                        ),
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      Text(
                        "Password",
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
                        obscureText: true,
                        decoration: InputDecoration(
                          suffix: const Icon(
                            Icons.edit,
                            size: 13,
                          ),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10)),
                          // focusedBorder: OutlineInputBorder(
                          //     borderRadius: BorderRadius.circular(10),
                          //     borderSide:
                          //         const BorderSide(color: Color(0XFFCACED8))),
                          // enabledBorder: UnderlineInputBorder(
                          //     borderRadius: BorderRadius.circular(10),
                          //     borderSide:
                          //         const BorderSide(color: Color(0XFFCACED8))),
                        ),
                      ),
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
}
