import 'package:flutter/cupertino.dart';
import 'package:sky_note/forgottenpassword.dart';
import 'package:sky_note/login.dart';
import 'package:sky_note/newtexts.dart';
import 'package:sky_note/profile.dart';
import 'package:sky_note/utils/screens/onboarding.dart';
import 'package:sky_note/utils/screens/splashscreen.dart';
import 'package:flutter/material.dart';
// import 'package:sky_note/viewtexts.dart';
import '../../home.dart';

class AppRoutes {
  Map<String, Widget Function(BuildContext ctx)> routes =
      <String, WidgetBuilder>{
    "/splash": (ctx) => const SplashScreen(),
    "/onboarding": (ctx) => const OnboardingScreen(),
    "/home": (ctx) => const MyHomePage(),
    "/login": (ctx) => const LoginPage(),
    "/txts": (ctx) => const TextPage(),
    "/profile": (ctx) =>  const Profile(),
    "/fpassword": (ctx) => const ForgottenPassword(),
    // '/viewnote': (ctx) => const ViewTexts()
  };
}
