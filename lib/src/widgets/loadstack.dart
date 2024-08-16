import 'package:flutter/material.dart';

class ClLoadStack extends StatelessWidget {
  final List<Widget> children;
  final bool isLoading;

  const ClLoadStack({
    required this.isLoading,
    required this.children,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        ...children,
        if (isLoading)
          Container(
            color: Colors.black.withOpacity(0.5),
            child: const Center(
              child: CircularProgressIndicator(),
            ),
          ),
      ],
    );
  }
}
