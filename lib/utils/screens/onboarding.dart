import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sky_note/utils/images.dart';
import 'package:sky_note/utils/texts.dart';

import '../colors.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  int currentIndex = 0;

  List<String> texts = [
    AppTexts.txt1,
    AppTexts.txt2,
    AppTexts.txt3,
  ];
  List<String> images = [
    AppImages.onboard1,
    AppImages.onboard2,
    AppImages.onboard3,
  ];
  List<String> otexts = [
    AppTexts.txt4,
    AppTexts.txt5,
    AppTexts.txt6,
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0XFF00AFEF),
      body: SingleChildScrollView(
        child: Stack(
          children: [
            Center(
              child: Column(
                //crossAxisAlignment: CrossAxisAlignment.end,
                //mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  const SizedBox(
                    height: 20,
                  ),
                  Image.asset(
                    images[currentIndex],
                    height: 400,
                    width: 350,
                  ),
                   const SizedBox(
                    height: 80,
                  ),
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: Container(
                      height: 330,
                      width: MediaQuery.of(context).size.width,
                      decoration: const BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(40),
                            topRight: Radius.circular(40)),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: Column(
                          children: [
                            Row(
                              mainAxisSize: MainAxisSize.min,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                for (int i = 0; i < images.length; i++)
                                  i == currentIndex
                                      ? OnboardingScreen(true)
                                      : OnboardingScreen(false)
                              ],
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            Text(
                              texts[currentIndex],
                              style: GoogleFonts.poppins(
                                  textStyle: TextStyle(
                                      color: AppColor.txt,
                                      fontWeight: FontWeight.w600,
                                      fontSize: 20)),
                            ),
                            const SizedBox(
                              height: 15,
                            ),
                            Text(
                              otexts[currentIndex],
                              textAlign: TextAlign.center,
                              style: GoogleFonts.poppins(
                                  textStyle: TextStyle(
                                      color: AppColor.txt,
                                      fontWeight: FontWeight.w400,
                                      fontSize: 13)),
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            Column(
                              children: [
                                SizedBox(
                                  width: 150,
                                  height: 40,
                                  child: MaterialButton(
                                    onPressed: () {
                                      if (currentIndex == 2) {
                                        Navigator.pushReplacementNamed(
                                            context, '/login');
                                      } else {
                                        setState(() => currentIndex++);
                                      }
                                    },
                                    color: AppColor.primary,
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(40)),
                                    child: Center(
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Text(
                                            currentIndex == 2
                                                ? 'Get Started'
                                                : "Next",
                                            style: GoogleFonts.poppins(
                                                textStyle: const TextStyle(
                                                    fontWeight:
                                                        FontWeight.w500,
                                                    color: Color(0XFFFFFFFF),
                                                    fontSize: 16)),
                                          ),
                                          const Icon(
                                            Icons.arrow_forward_ios,
                                            size: 18,
                                            color: Colors.white,
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                                const SizedBox(
                                  height: 20,
                                ),
                                currentIndex == 2
                                    ? const Center()
                                    : TextButton(
                                        onPressed: () {
                                          setState(() => currentIndex = 2);
                                        },
                                        child: Text("skip",
                                            style: GoogleFonts.poppins(
                                              textStyle: const TextStyle(
                                                  fontWeight: FontWeight.w400,
                                                  fontSize: 18,
                                                  color: Color.fromARGB(
                                                      255, 118, 114, 114),
                                                  decoration: TextDecoration
                                                      .underline),
                                            ))),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ignore: non_constant_identifier_names
  Widget OnboardingScreen(bool isActive) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 100),
      height: 10,
      width: 10,
      margin: const EdgeInsets.symmetric(horizontal: 10),
      decoration: BoxDecoration(
        color: isActive ? AppColor.primary : Colors.grey,
        shape: BoxShape.circle,
      ),
    );
  }
}
