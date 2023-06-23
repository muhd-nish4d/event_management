import 'package:event_management/Bloc/all_user/all_user_bloc_bloc.dart';
import 'package:event_management/Bloc/fillup/fillup_bloc.dart';
import 'package:event_management/Bloc/upload_image/post_image_bloc.dart';
import 'package:event_management/screens/splash/splash_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

import 'Bloc/log/login_bloc.dart';

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
    return MultiBlocProvider(
      providers: [
        BlocProvider<LoginBloc>.value(value: LoginBloc()),
        BlocProvider<FillupBloc>.value(value: FillupBloc()),
        BlocProvider<AllUserBlocBloc>.value(value: AllUserBlocBloc()),
        BlocProvider<PostImageBloc>.value(value: PostImageBloc())
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Event Management',
        theme: ThemeData(
          textTheme: GoogleFonts.rubikTextTheme(),
          useMaterial3: true,
          primarySwatch: Colors.orange,
        ),
        home: const ScreenSplash(),
        // home: const ScreenUserChose(),
      ),
    );
  }
}
