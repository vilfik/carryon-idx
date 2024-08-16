import 'package:myapp/src/widgets/button.dart';
import 'package:myapp/src/widgets/input.dart';
import 'package:myapp/src/widgets/loadstack.dart';
import 'package:myapp/src/widgets/snack.dart';
import 'package:myapp/src/widgets/text.dart';
import 'package:myapp/src/pages/auth/signup.dart';
import 'package:myapp/src/pages/home.dart';
import 'package:myapp/src/services/auth.dart';
import 'package:flutter/material.dart';

class AuthSignIn extends StatefulWidget {
  const AuthSignIn({super.key});

  @override
  State<AuthSignIn> createState() => _AuthSignInState();
}

class _AuthSignInState extends State<AuthSignIn> {
  final usernameController = TextEditingController();
  final passwordController = TextEditingController();

  bool isLoading = false;

  void signInUser() async {
    final username = usernameController.text;
    final password = passwordController.text;

    setState(() {
      isLoading = true;
    });

    String result = await AuthServices().signInUser(
      username: username,
      password: password,
    );

    if (result == "true") {
      if (!mounted) return;

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) {
            return const Home();
          },
        ),
      );
    } else {
      setState(() {
        isLoading = false;
      });

      if (!mounted) return;

      showSnack(context, result);
    }
  }

  @override
  void dispose() {
    usernameController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ClLoadStack(
      isLoading: isLoading,
      children: <Widget>[
        Scaffold(
          body: SafeArea(
            bottom: false,
            child: ListView(
              shrinkWrap: true,
              padding: const EdgeInsets.all(24),
              children: <Widget>[
                Center(
                  child: Image.network(
                    "https://i.postimg.cc/mknFSdXR/signin.png",
                    width: 156,
                    cacheHeight: 156,
                    height: 156,
                  ),
                ),
                const SizedBox(height: 24),
                const Center(child: ClTitle("Get Back in the Mix")),
                const SizedBox(height: 8),
                const Center(child: ClSubTitle("We are almost out of juice.")),
                const SizedBox(
                  height: 24,
                ),
                ClInput(
                  controller: usernameController,
                  hint: "Enter your username...",
                  autoFocus: true,
                  focusNext: true,
                  suffix: "@carryon",
                ),
                ClInput(
                  controller: passwordController,
                  hint: "Enter password...",
                  inputType: TextInputType.visiblePassword,
                  obscureText: true,
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
                  text: "Sign in",
                  onPressed: signInUser,
                ),
                const SizedBox(
                  height: 12,
                ),
                ClTextButtonPrimary(
                  text: "Don't have an account? Sign up",
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
                )
              ],
            ),
          ),
        ),
      ],
    );
  }
}
