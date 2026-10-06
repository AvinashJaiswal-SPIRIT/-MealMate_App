import 'package:flutter/material.dart';
import 'sign_up.dart';
import 'login_widgets.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool showPassword = false;
  bool remember = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: lightBg,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(15, 15, 15, 20),
          child: Column(
            children: [
              Image.asset(
                'assets/logo/meal_logo.png',
                width: 55,
                height: 55,
              ),

              const SizedBox(height: 8),
              const Text(
                'MealMate',
                style: TextStyle(fontSize: 21, fontWeight: FontWeight.bold),
              ),
              const Text(
                'Delicious recipes at your fingertips',
                style: TextStyle(fontSize: 9, color: Colors.black54),
              ),

              const SizedBox(height: 20),

              const WelcomeCard(),


              const SizedBox(height: 15),

              const LoginField(
                label: 'Email Address',
                hint: 'chef@mealmate.app',
                icon: Icons.email_outlined,
              ),

              const SizedBox(height: 12),

              LoginField(
                label: 'Password',
                hint: '********',
                icon: Icons.lock_outline,
                obscureText: !showPassword,
                suffix: IconButton(
                  icon: Icon(
                    showPassword ? Icons.visibility : Icons.visibility_off,
                    size: 18,
                  ),
                  onPressed: () {
                    setState(() => showPassword = !showPassword);
                  },
                ),
              ),
              Row(
                children: [
                  Checkbox(
                    value: remember,
                    onChanged: (value) {
                      setState(() => remember = value!);
                    },
                    activeColor: Colors.green.shade700,
                    visualDensity: VisualDensity.compact,
                  ),
                  const Text(
                    'Remember this kitchen device',
                    style: TextStyle(fontSize: 9),
                  ),
                  const Spacer(),
                  Text(
                    'Forgot Password?',
                    style: TextStyle(
                      color: primaryRed,
                      fontSize: 9,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 5),

              LoginButton(
                text: 'Log In  →',
                onPressed: () {},
              ),

              const SizedBox(height: 18),

              Row(
                children: [
                  const Expanded(child: Divider()),
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 12),
                    child: Text(
                      'OR CONTINUE WITH',
                      style: TextStyle(fontSize: 12),
                    ),
                  ),
                  const Expanded(child: Divider()),
                ],
              ),

              const SizedBox(height: 12),

              Row(
                children: [
                  SocialButton(
                    text: 'Google',
                    icon: Image.asset(
                      'assets/logo/google_logo.jpg',
                      width: 18,
                      height: 18,
                      fit: BoxFit.contain,
                    ),
                  ),

                  const SizedBox(width: 8),

                  SocialButton(
                    text: 'Apple',
                    icon: const Icon(
                      Icons.apple,
                      size: 18,
                    ),
                  ),
                ],
              ),


              const SizedBox(height: 18),

              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    "Don't have an account?  ",
                    style: TextStyle(fontSize: 10),
                  ),

                  TextButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const SignupPage(),
                        ),
                      );
                    },
                    style: TextButton.styleFrom(
                      padding: EdgeInsets.zero,
                      minimumSize: Size.zero,
                      tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                    ),
                    child: const Text(
                      'Sign Up',
                      style: TextStyle(
                        color: primaryRed,
                        fontSize: 10,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 18),

              const Text(
                'Continue as Guest  →',
                style: TextStyle(
                  color: Color(0xFF9A4B00),
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: 25),

              const Text(
                '♨  OVER 10,000+ HOME CHEF RECIPES',
                style: TextStyle(
                  fontSize: 8,
                  color: Colors.black54,
                ),
              ),

            ],

          ),
        ),
      ),
    );
  }
}

