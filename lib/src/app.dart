
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:myapp/src/pages/home.dart';
import 'package:myapp/src/pages/welcome.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Carry On',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        fontFamily: "Muli",
        fontFamilyFallback: const <String>['Noto Sans'],
        colorScheme: const ColorScheme.dark(),
        useMaterial3: true,
      ),
      home: StreamBuilder(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Scaffold(
              body: Center(
                child: CircularProgressIndicator(),
              ),
            );
          } else if (snapshot.hasData) {
            return const Home();
          } else {
            return const Welcome();
          }
        },
      ),
    );
  }
}
