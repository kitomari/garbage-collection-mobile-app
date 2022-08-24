// import 'package:collection_app/providers/customer_provider.dart';
// import 'package:collection_app/providers/user_provider.dart';
import 'package:collection_app/screens/home_screen/client_screen.dart';
import 'package:collection_app/screens/home_screen/home.dart';
import 'package:collection_app/screens/login_screen.dart';
import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const LoginScreen(),
      routes: {
        '/home':(context) => HomeScreen(),
        '/login':(context) => LoginScreen(),
        '/client':(context) => ClientScreen(),
      },
      // home: BottomBar(),
    );
  }
}

