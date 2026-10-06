import 'package:flutter/material.dart';
import 'login_widgets.dart';
import 'signup_widgets.dart';

class SignupPage extends StatefulWidget {
  const SignupPage({super.key});

  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  bool showPassword = false;
  bool agree = false;
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  String selectedDiet = 'No Restrictions';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFFF3F3),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(15),
          child: Column(
            children: [
              const SignupLogo(),

              const SizedBox(height: 12),

              const ActiveCooks(),

              const SizedBox(height: 10),

              const Text(
                'Create your Account',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: 5),

              const Text(
                'Join thousands of home cooks discovering new\n'
                    'favorites every day.',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 11,
                  color: Colors.black54,
                ),
              ),

              const SizedBox(height: 18),

              _signupForm(),

              const SizedBox(height: 12),

              const GuaranteeCard(),

              const SizedBox(height: 18),

              _loginLink(),

              const SizedBox(height: 15),

              const Text(
                '❤️ 100% Free • Powered by TheMealDB API',
                style: TextStyle(fontSize: 8),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _signupForm() {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        children: [
          LoginField(
            controller: nameController,
            label: 'Full Name',
            hint: 'Alex Morgan',
            icon: Icons.person_outline,
            suffix: const Text(
              'Required',
              style: TextStyle(fontSize: 9),
            ),
          ),

          const SizedBox(height: 12),

          LoginField(
            controller: emailController,
            label: 'Email Address',
            hint: 'alex@example.com',
            icon: Icons.email_outlined,
            suffix: const Text(
              "We don't spam",
              style: TextStyle(fontSize: 9),
            ),
          ),

          const SizedBox(height: 12),

          LoginField(
            controller: passwordController,
            label: 'Password',
            hint: 'SpiceKitchen2024!',
            icon: Icons.lock_outline,
            obscureText: !showPassword,
            suffix: IconButton(
              icon: Icon(
                showPassword
                    ? Icons.visibility_outlined
                    : Icons.visibility_off_outlined,
                size: 17,
              ),
              onPressed: () {
                setState(() {
                  showPassword = !showPassword;
                });
              },
            ),
          ),

          const SizedBox(height: 10),

          _passwordStrength(),

          const SizedBox(height: 12),

          _dietaryPreferences(),

          const SizedBox(height: 10),

          _terms(),

          const SizedBox(height: 10),

          LoginButton(
            text: 'Create Account 🎉',
            onPressed: () {
              if (!agree) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text(
                      'Please agree to Terms & Privacy Policy',
                    ),
                  ),
                );
                return;
              }

              // Signup logic will be added later.
            },
          ),
        ],
      ),
    );
  }

  Widget _passwordStrength() {
    return Column(
      children: [
        Row(
          children: List.generate(
            3,
                (index) => Expanded(
              child: Container(
                height: 4,
                margin: const EdgeInsets.only(right: 3),
                decoration: BoxDecoration(
                  color: Colors.green.shade700,
                  borderRadius: BorderRadius.circular(5),
                ),
              ),
            ),
          ),
        ),

        const SizedBox(height: 5),

        const Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Contains letters, numbers & symbols',
              style: TextStyle(
                fontSize: 8,
                color: Colors.black54,
              ),
            ),
            Text(
              'PROTECTED',
              style: TextStyle(
                fontSize: 8,
                color: Colors.green,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _dietaryPreferences() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Dietary Preferences',
              style: TextStyle(
                fontSize: 11,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              'Tap to customize',
              style: TextStyle(
                fontSize: 9,
                color: Colors.black54,
              ),
            ),
          ],
        ),

        const SizedBox(height: 4),

        const Text(
          'Tailor your daily recipes stream immediately:',
          style: TextStyle(
            fontSize: 8,
            color: Colors.black54,
          ),
        ),

        const SizedBox(height: 7),

        Wrap(
          spacing: 7,
          runSpacing: 7,
          children: [
            DietChip(
              text: '🍴 No Restrictions',
              selected: selectedDiet == 'No Restrictions',
              onTap: () {
                setState(() {
                  selectedDiet = 'No Restrictions';
                });
              },
            ),
            DietChip(
              text: 'Vegetarian',
              selected: selectedDiet == 'Vegetarian',
              onTap: () {
                setState(() {
                  selectedDiet = 'Vegetarian';
                });
              },
            ),
            DietChip(
              text: '⚙ Gluten-Free',
              selected: selectedDiet == 'Gluten-Free',
              onTap: () {
                setState(() {
                  selectedDiet = 'Gluten-Free';
                });
              },
            ),
            DietChip(
              text: 'Halal',
              selected: selectedDiet == 'Halal',
              onTap: () {
                setState(() {
                  selectedDiet = 'Halal';
                });
              },
            ),
            DietChip(
              text: 'Keto',
              selected: selectedDiet == 'Keto',
              onTap: () {
                setState(() {
                  selectedDiet = 'Keto';
                });
              },
            ),
          ],
        )
      ],
    );
  }

  Widget _terms() {
    return Row(
      children: [
        Checkbox(
          value: agree,
          activeColor: Colors.green.shade700,
          visualDensity: VisualDensity.compact,
          onChanged: (value) {
            setState(() {
              agree = value ?? false;
            });
          },
        ),

        const Expanded(
          child: Text.rich(
            TextSpan(
              text: 'I agree to MealMate ',
              children: [
                TextSpan(
                  text: 'Terms',
                  style: TextStyle(
                    color: primaryRed,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                TextSpan(text: ' & '),
                TextSpan(
                  text: 'Privacy Policy',
                  style: TextStyle(
                    color: primaryRed,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            style: TextStyle(fontSize: 9),
          ),
        ),
      ],
    );
  }

  Widget _loginLink() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text(
          'Already have an account? ',
          style: TextStyle(fontSize: 10),
        ),

        GestureDetector(
          onTap: () {
            Navigator.pop(context);
          },
          child: const Text(
            'Log In',
            style: TextStyle(
              color: primaryRed,
              fontSize: 10,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ],
    );
  }
}