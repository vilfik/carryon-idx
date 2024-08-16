import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:myapp/src/pages/welcome.dart';
import 'package:myapp/src/services/auth.dart';
import 'package:myapp/src/widgets/button.dart';

class HomeProfile extends StatefulWidget {
  const HomeProfile({super.key});

  @override
  State<HomeProfile> createState() => _HomeProfileState();
}

class _HomeProfileState extends State<HomeProfile> {
  User? user;

  @override
  void initState() {
    super.initState();
    user = AuthServices().getCurrentUser();
  }

  void signOut() async {
    await AuthServices().signOutUser();
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(
        builder: (context) {
          return const Welcome();
        },
      ),
      (Route<dynamic> route) => false,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Profile',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: SafeArea(
        child: ListView(
          shrinkWrap: true,
          padding: const EdgeInsets.only(top: 24),
          children: <Widget>[
            Center(
              child: Image.network(
                user!.photoURL!,
                width: 128,
                cacheHeight: 128,
                height: 128,
              ),
            ),
            const SizedBox(height: 24),
            Tag(
              "Username",
              user!.displayName!,
              firstTag: true,
            ),
            const SizedBox(height: 12),
            Padding(
              padding: EdgeInsets.all(24),
              child: ElevatedButton.icon(
                onPressed: signOut,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red,
                  foregroundColor: Colors.white,
                ),
                icon: Icon(Icons.logout),
                label: Text("Signout"),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class Tag extends StatelessWidget {
  final String text;
  final String value;
  final bool firstTag;

  const Tag(
    this.text,
    this.value, {
    this.firstTag = false,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        // if first tag, add border to top else only at bottom
        border: firstTag!
            ? const Border.symmetric(
                horizontal: BorderSide(
                    color: Color.fromARGB(32, 158, 158, 158), width: 1),
              )
            : const Border(
                bottom: BorderSide(
                    color: Color.fromARGB(32, 158, 158, 158), width: 1),
              ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Text(
            text,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(
            value,
            style: const TextStyle(
              color: Colors.grey,
              fontSize: 18,
            ),
          ),
        ],
      ),
    );
  }
}
