import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:myapp/src/pages/home/profile.dart';
import 'package:myapp/src/pages/welcome.dart';
import 'package:myapp/src/services/auth.dart';
import 'package:myapp/src/widgets/button.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  User? user;

  @override
  void initState() {
    super.initState();
    user = AuthServices().getCurrentUser();
  }

  void signOut() async {
    await AuthServices().signOutUser();
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) {
          return const Welcome();
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Image.network(
                  'https://i.postimg.cc/d1qdQZZM/icon-64.png',
                  width: 26,
                  height: 26,
                  cacheHeight: 26,
                  cacheWidth: 26,
                ),
                const SizedBox(
                  width: 12,
                ),
                const Text(
                  'Carry On',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            IconButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const HomeProfile(),
                  ),
                );
              },
              iconSize: 32,
              padding: EdgeInsets.zero,
              icon: Image.network(
                user!.photoURL!,
                width: 32,
                height: 32,
                cacheHeight: 32,
                cacheWidth: 32,
              ),
            ),
          ],
        ),
      ),
      body: Center(
        child: ClElevatedButtonPrimary(text: "Logout", onPressed: signOut),
      ),
    );
  }
}
