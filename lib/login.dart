import 'package:flutter/material.dart';

import 'widgets.dart';
import 'auth_widgets.dart';
import 'home.dart';
import 'signup.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  String errorMessage = "";
  bool _rememberMe = false;
  bool _obscurePassword = true;

  void login() {
    String email = _emailController.text.trim();
    if (email.isEmpty || !email.contains('@') || !email.contains('.com')) {
      setState(() => errorMessage = "Please enter a valid email address");
      return;
    }
    String password = _passwordController.text;
    if (password.length < 6) {
      setState(() => errorMessage = "Password must be at least 6 characters");
      return;
    }
    // Add api here for login
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => const HomeShell()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFAF9F6),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 20),
              const HeaderLogoBox(),
              const SizedBox(height: 12),
              const Text(
                "MealMate",
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              const Text(
                "Delicious recipes at your fingertips",
                style: TextStyle(color: Colors.grey, fontSize: 12),
              ),
              const SizedBox(height: 32),

              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: const Color(0xFFD94A38).withValues(alpha: 0.05),
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    Text(
                      "Welcome back!",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 8),
                    Text(
                      "Log in to view your liked meals, custom meal plans, and\nfavorite recipes.",
                      style: TextStyle(color: Colors.black54, fontSize: 12),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 24),

              const AuthLabel(leftText: "Email Address"),
              AuthTextField(
                controller: _emailController,
                hintText: "chef@mealmate.app",
                prefixIcon: Icons.email_outlined,
              ),
              const SizedBox(height: 16),

              const AuthLabel(
                leftText: "Password",
                rightText: "Forgot Password?",
                rightColor: Color(0xFFD94A38),
                isBoldRight: true,
              ),
              AuthTextField(
                controller: _passwordController,
                hintText: "********",
                prefixIcon: Icons.lock_outline,
                obscureText: _obscurePassword,
                suffixIcon: IconButton(
                  icon: Icon(
                    _obscurePassword
                        ? Icons.visibility_off_outlined
                        : Icons.visibility_outlined,
                    color: Colors.grey,
                  ),
                  onPressed: () =>
                      setState(() => _obscurePassword = !_obscurePassword),
                ),
              ),

              if (errorMessage.isNotEmpty) ...[
                const SizedBox(height: 8),
                Text(errorMessage, style: const TextStyle(color: Colors.red)),
              ],
              const SizedBox(height: 16),

              GestureDetector(
                onTap: () => setState(() => _rememberMe = !_rememberMe),
                child: Row(
                  children: [
                    Container(
                      width: 20,
                      height: 20,
                      decoration: BoxDecoration(
                        color: _rememberMe ? Colors.green : Colors.transparent,
                        border: Border.all(
                          color: _rememberMe ? Colors.green : Colors.grey,
                        ),
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: _rememberMe
                          ? const Icon(
                              Icons.check,
                              color: Colors.white,
                              size: 14,
                            )
                          : null,
                    ),
                    const SizedBox(width: 8),
                    const Text(
                      "Remember this Kitchen device",
                      style: TextStyle(color: Colors.grey, fontSize: 12),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 24),
              PrimaryButton(text: "Log In", onPressed: login),
              const SizedBox(height: 24),

              Row(
                children: [
                  Expanded(
                    child: Divider(color: Colors.grey.withValues(alpha: 0.3)),
                  ),
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16),
                    child: Text(
                      "OR CONTINUE WITH",
                      style: TextStyle(
                        color: Colors.grey,
                        fontSize: 10,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Expanded(
                    child: Divider(color: Colors.grey.withValues(alpha: 0.3)),
                  ),
                ],
              ),
              const SizedBox(height: 24),

              Row(
                children: const [
                  SocialButton(
                    text: "Google",
                    image: 'assets/logo/google_logo.jpg',
                  ),
                  SizedBox(width: 16),
                  SocialButton(
                    text: "Apple",
                    image: 'assets/logo/apple_logo.png',
                  ),
                ],
              ),
              const SizedBox(height: 32),

              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    "Don't have an account? ",
                    style: TextStyle(color: Colors.grey),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const SignUpPage(),
                        ),
                      );
                    },
                    child: const Text(
                      "Sign Up",
                      style: TextStyle(
                        color: Color(0xFFD94A38),
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              GestureDetector(
                onTap: () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => const HomeShell()),
                  );
                },
                child: const Text(
                  "Continue as Guest \u{2192}",
                  style: TextStyle(
                    color: Color(0xFFD94A38),
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const SizedBox(height: 32),
              const Text(
                "\u{1F373} OVER 10,000+ HOME CHEF RECIPES",
                style: TextStyle(
                  color: Colors.grey,
                  fontSize: 10,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 1,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
