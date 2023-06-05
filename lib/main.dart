import 'package:event_management/screens/user/user_chose.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'screens/authentication/number.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Event Management',
      theme: ThemeData(
        textTheme: GoogleFonts.rubikTextTheme(),
        useMaterial3: true,
        primarySwatch: Colors.orange,
      ),
      // home: ScreenLogin(),
      home: const ScreenUserChose(),
    );
  }
}
