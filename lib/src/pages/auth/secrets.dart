import 'package:myapp/src/widgets/button.dart';
import 'package:myapp/src/widgets/snack.dart';
import 'package:myapp/src/widgets/text.dart';
import 'package:myapp/src/pages/home.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class AuthSecrets extends StatefulWidget {
  final String username;
  final List<String> secrets;
  final String profile;

  const AuthSecrets(
    this.username,
    this.secrets,
    this.profile, {
    super.key,
  });

  @override
  State<AuthSecrets> createState() => _AuthSecretsState();
}

class _AuthSecretsState extends State<AuthSecrets> {
  bool secretCopied = false;
  String username = "";

  @override
  void initState() {
    super.initState();
    username = widget.username;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        bottom: false,
        child: ListView(
          shrinkWrap: true,
          padding: const EdgeInsets.all(24),
          children: <Widget>[
            Center(
              child: Image.network(
                widget.profile,
                width: 156,
                cacheHeight: 156,
                height: 156,
              ),
            ),
            const SizedBox(height: 24),
            const Center(child: ClTitle("Save these secrets")),
            const SizedBox(height: 24),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                ClSubTitle("Hi @$username"),
                const ClSubTitle("Welcome to Carry On!"),
                const SizedBox(height: 16),
                const ClSubTitle(
                  "Here we believe in anonymity. So, you don't need to share any of your personal details.\n\nThus, incase you forget your password, we can't help you. But don't worry, we have secret codes for that.\n\nJust copy them from below and keep them safe. You can always use them to recover your account.",
                  fontSize: 18,
                ),
              ],
            ),
            const SizedBox(
              height: 24,
            ),
            Card(
              color: Colors.grey[900],
              child: Padding(
                padding: const EdgeInsets.all(12),
                child: SelectableText(
                  widget.secrets.join(" "),
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 12,
            ),
            ClTextButtonPrimary(
              text: "Copy Secret",
              onPressed: () {
                // Copy secrets to clipboard
                Clipboard.setData(
                    ClipboardData(text: widget.secrets.join(" ")));

                // Show snackbar
                showSnack(context, "Secrets copied to clipboard");

                // Update state
                setState(() {
                  secretCopied = true;
                });
              },
            ),
            const SizedBox(
              height: 48,
            ),
          ],
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(12),
        child: ClElevatedButtonPrimary(
          text: "Let's Go",
          onPressed: secretCopied
              ? () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const Home(),
                    ),
                  );
                }
              : null,
        ),
      ),
    );
  }
}
