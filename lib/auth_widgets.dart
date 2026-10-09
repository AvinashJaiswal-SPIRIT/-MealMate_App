import 'package:flutter/material.dart';

// Reusable text field for login and signup forms.
class AuthTextField extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  final IconData prefixIcon;
  final bool obscureText;
  final Widget? suffixIcon;

  const AuthTextField({
    super.key,
    required this.controller,
    required this.hintText,
    required this.prefixIcon,
    this.obscureText = false,
    this.suffixIcon,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      obscureText: obscureText,
      decoration: InputDecoration(
        hintText: hintText,
        filled: true,
        fillColor: Colors.white,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide.none,
        ),
        prefixIcon: Icon(prefixIcon, color: Colors.grey),
        suffixIcon: suffixIcon,
      ),
    );
  }
}

// Displays a field label and an optional right-side message.
class AuthLabel extends StatelessWidget {
  final String leftText;
  final String rightText;
  final Color rightColor;
  final bool isBoldRight;

  const AuthLabel({
    super.key,
    required this.leftText,
    this.rightText = "",
    this.rightColor = Colors.grey,
    this.isBoldRight = false,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            leftText,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 14,
            ),
          ),
          if (rightText.isNotEmpty)
            Text(
              rightText,
              style: TextStyle(
                color: rightColor,
                fontSize: 12,
                fontWeight: isBoldRight
                    ? FontWeight.bold
                    : FontWeight.normal,
              ),
            ),
        ],
      ),
    );
  }
}

// Creates a reusable button for Google, Apple, or other sign-in options.
class SocialButton extends StatelessWidget {
  final String text;
  final String image;

  const SocialButton({
    super.key,
    required this.text,
    required this.image,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.white,
          foregroundColor: Colors.black,
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(24),
            side: BorderSide(
              color: Colors.grey.withValues(alpha: 0.2),
            ),
          ),
          padding: const EdgeInsets.symmetric(vertical: 16),
        ),
        onPressed: () {},
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(image, width: 20, height: 20),
            const SizedBox(width: 8),
            Text(
              text,
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }
}

// Displays the app logo in a rounded square.
class HeaderLogoBox extends StatelessWidget {
  const HeaderLogoBox({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 64,
      height: 64,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
      ),
      clipBehavior: Clip.antiAlias,
      child: Image.asset(
        'assets/logo/app_logo.png',
        fit: BoxFit.cover,
      ),
    );
  }
}