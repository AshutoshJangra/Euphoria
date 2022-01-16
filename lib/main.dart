import 'dart:ui';

import '/provider/google_sign_in.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import './configuration.dart';

// import '/login.dart';
import './screens/home.dart';
import './screens/upload.dart';
import './screens/movie.dart';
import './screens/navigator_bar.dart';
import './screens/auth.dart';
import './screens/router.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
  // ignore: prefer_const_constructors
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
    systemNavigationBarColor: bgPrimeDark,
    statusBarColor: bgPrimeDark,
  ));
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) => ChangeNotifierProvider(
      create: (context) => GoogleSignInProvider(),
      child: MaterialApp(
        title: 'euphoria',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
            fontFamily: 'Quicksand', scaffoldBackgroundColor: bgPrimeDark),
        home: const RouterPage(),
      ));
}
