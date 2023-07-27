import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:sky_note/home.dart';
import 'package:sky_note/utils/screens/approutes.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:sky_note/utils/screens/splashscreen.dart';
import 'firebase_options.dart';

Future<void> main() async {
  await Hive.initFlutter();
  await Hive.openBox('dark mode');

  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final User? _user = FirebaseAuth.instance.currentUser;
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
        valueListenable: Hive.box('dark mode').listenable(),
        builder: (context, Box box, child) {
          bool getValue = box.get('dark mode', defaultValue: true);
          return MaterialApp(
            title: 'Sky Note',
            themeMode: getValue ? ThemeMode.dark : ThemeMode.light,
            darkTheme: ThemeData.dark(),
            debugShowCheckedModeBanner: false,
            theme: ThemeData(
              appBarTheme: const AppBarTheme(
                  color: Colors.white, foregroundColor: Colors.black),
            ),
            //  AppBarTheme(color: Colors.white),
            initialRoute: _user != null ? '/home' : '/splash',
            routes: AppRoutes().routes,
            home: SplashScreen(),
          );
        });
  }
}

class MainPage extends StatelessWidget {
  const MainPage({super.key});

  @override
  Widget build(BuildContext context) => Scaffold(
        body: StreamBuilder<User?>(
            stream: FirebaseAuth.instance.authStateChanges(),
            builder: (context, snapshot) {
              return const MyHomePage();
            }),
      );
}
