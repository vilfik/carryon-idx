import 'package:myapp/src/widgets/button.dart';
import 'package:myapp/src/widgets/input.dart';
import 'package:myapp/src/widgets/loadstack.dart';
import 'package:myapp/src/widgets/snack.dart';
import 'package:myapp/src/widgets/text.dart';
import 'package:myapp/src/pages/auth/secrets.dart';
import 'package:myapp/src/pages/auth/signin.dart';
import 'package:myapp/src/services/auth.dart';
import 'package:flutter/material.dart';

class AuthSignUp extends StatefulWidget {
  const AuthSignUp({super.key});

  @override
  State<AuthSignUp> createState() => _AuthSignUpState();
}

class _AuthSignUpState extends State<AuthSignUp> {
  final usernameController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  bool isLoading = false;

  void signUpUser() async {
    final username = usernameController.text;
    final password = passwordController.text;
    final confirmPassword = confirmPasswordController.text;

    setState(() {
      isLoading = true;
    });

    SignUpResponse result = await AuthServices().signUpUser(
      username: username,
      password: password,
      confirmPassword: confirmPassword,
    );

    if (result.success) {
      if (!mounted) return;

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) {
            return AuthSecrets(
              result.username!,
              result.secrets!,
              result.profile!,
            );
          },
        ),
      );
    } else {
      setState(() {
        isLoading = false;
      });

      if (!mounted) return;

      showSnack(context, result.error!);
    }

    // Implement user registration logic here
  }

  @override
  void dispose() {
    usernameController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
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
                    "https://i.postimg.cc/rmQ4Dy5D/signup.png",
                    width: 156,
                    cacheHeight: 156,
                    height: 156,
                  ),
                ),
                const SizedBox(height: 24),
                const Center(child: ClTitle("Join the Fun")),
                const SizedBox(height: 8),
                const Center(child: ClSubTitle("We believe in anonymity.")),
                const SizedBox(
                  height: 24,
                ),
                ClInput(
                  controller: usernameController,
                  hint: "Pick a username...",
                  focusNext: true,
                  autoFocus: true,
                  suffix: "@carryon",
                ),
                ClInput(
                    controller: passwordController,
                    hint: "Create a password...",
                    inputType: TextInputType.visiblePassword,
                    obscureText: true,
                    focusNext: true),
                ClInput(
                  controller: confirmPasswordController,
                  hint: "Confirm password...",
                  inputType: TextInputType.visiblePassword,
                  obscureText: true,
                ),
                const SizedBox(
                  height: 32,
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
                  text: "Create Account",
                  onPressed: signUpUser,
                ),
                const SizedBox(
                  height: 12,
                ),
                ClTextButtonPrimary(
                  text: "Already have an account? Sign in",
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
                )
              ],
            ),
          ),
        ),
      ],
    );
  }
}
