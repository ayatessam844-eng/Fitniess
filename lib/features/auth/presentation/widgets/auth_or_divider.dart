import 'package:flutter/material.dart';

class AuthOrDivider extends StatelessWidget {
  const AuthOrDivider({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const Expanded(child: Divider(color: Colors.white24)),
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 8),
          child: Text('Or', style: TextStyle(color: Colors.white38, fontSize: 12)),
        ),
        const Expanded(child: Divider(color: Colors.white24)),
      ],
    );
  }
}
