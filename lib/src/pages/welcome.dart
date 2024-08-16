import 'package:myapp/src/widgets/button.dart';
import 'package:myapp/src/widgets/text.dart';
import 'package:myapp/src/pages/auth/signin.dart';
import 'package:myapp/src/pages/auth/signup.dart';
import 'package:flutter/material.dart';

class Welcome extends StatelessWidget {
  const Welcome({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Image.network(
              "https://i.postimg.cc/cCCnwqcX/welcome.png",
              width: 156,
              cacheHeight: 156,
              height: 156,
            ),
            const SizedBox(
              height: 16,
            ),
            const ClTitle(
              "Carry On",
            ),
            const SizedBox(
              height: 8,
            ),
            const ClSubTitle(
              "Life is short. Let it out.",
            ),
          ],
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.symmetric(vertical: 12),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            ClElevatedButtonPrimary(
              text: "JOIN IN THE FUN",
              onPressed: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) {
                      return const AuthSignUp();
                    },
                  ),
                );
              },
            ),
            const SizedBox(
              height: 12,
            ),
            ClTextButtonPrimary(
              text: "SIGN IN",
              onPressed: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) {
                      return const AuthSignIn();
                    },
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
