import 'package:flutter/material.dart';

class SocialAuthRow extends StatelessWidget {
  final double circleSize;
  final VoidCallback? onFacebookTap;
  final VoidCallback? onGoogleTap;
  final VoidCallback? onAppleTap;

  const SocialAuthRow({
    super.key,
    this.circleSize = 42,
    this.onFacebookTap,
    this.onGoogleTap,
    this.onAppleTap,
  });

  Widget _circle(IconData icon, VoidCallback? onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: circleSize,
        height: circleSize,
        decoration: BoxDecoration(shape: BoxShape.circle, border: Border.all(color: Colors.white24)),
        child: Icon(icon, color: Colors.white, size: 18),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        _circle(Icons.facebook, onFacebookTap),
        const SizedBox(width: 16),
        // TODO swap w/ google svg icon (Icons.g_mobiledata isn't a real Google mark)
        _circle(Icons.g_mobiledata, onGoogleTap),
        const SizedBox(width: 16),
        _circle(Icons.apple, onAppleTap),
      ],
    );
  }
}
