import 'package:flutter/material.dart';

import 'widgets.dart';
import 'auth_widgets.dart';
import 'signup_widgets.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final _emailController = TextEditingController();
  final _nameController = TextEditingController();
  final _passwordController = TextEditingController();

  // Variables that store the current form state.
  String errorMessage = "";
  bool _agreedToTerms = true;
  String _selectedDiet = 'No Restrictions';
  bool _obscurePassword = true;

  // Variables used to display password strength.
  int _strengthLevel = 0;
  String _strengthLabel = "Weak";
  Color _strengthColor = Colors.red;

  @override
  void initState() {
    super.initState();
    _passwordController.addListener(_checkPasswordStrength);
  }

  @override
  void dispose() {
    _passwordController.removeListener(_checkPasswordStrength);
    _emailController.dispose();
    _nameController.dispose();
    _passwordController.dispose();

    super.dispose();
  }

  void _checkPasswordStrength() {
    String p = _passwordController.text;

    bool hasLetters = RegExp(r'[a-zA-Z]').hasMatch(p);
    bool hasNumbers = RegExp(r'[0-9]').hasMatch(p);
    bool hasSymbols = RegExp(r'[!@#$%^&*(),.?":{}|<>]').hasMatch(p);

    int score = 0;

    if (p.length > 5) score++;
    if (hasLetters && hasNumbers) score++;
    if (hasSymbols && p.length > 7) score++;

    // Updates the strength label, color, and bar.
    setState(() {
      if (p.isEmpty || score <= 1) {
        _strengthLevel = 0;
        _strengthLabel = "Weak";
        _strengthColor = Colors.red;
      } else if (score == 2) {
        _strengthLevel = 1;
        _strengthLabel = "Medium";
        _strengthColor = Colors.orange;
      } else {
        _strengthLevel = 2;
        _strengthLabel = "Strong";
        _strengthColor = Colors.green;
      }
    });
  }

  // Validates the form before continuing.
  void signUp() {
    String email = _emailController.text.trim();

    if (email.isEmpty || !email.contains('@') || !email.contains('.com')) {
      setState(() => errorMessage = "Please enter a valid email address");
      return;
    }

    // User must agree to the terms.
    if (!_agreedToTerms) {
      setState(
        () => errorMessage = "You must agree to the Terms & Privacy Policy",
      );
      return;
    }
    String password = _passwordController.text;

    if (password.length < 6) {
      setState(() => errorMessage = "Password must be at least 6 characters");
      return;
    }
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    // Main page layout.
    return Scaffold(
      backgroundColor: const Color(0xFFFAF9F6),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Padding(
                padding: EdgeInsets.all(35.0),
                child: HeaderLogoBox(),
              ),

              const SizedBox(height: 12),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 4,
                ),
                decoration: BoxDecoration(
                  color: Colors.green.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: const [
                    Icon(Icons.circle, color: Colors.green, size: 8),
                    SizedBox(width: 4),
                    Text(
                      "24,800+ active home cooks",
                      style: TextStyle(
                        color: Colors.green,
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 16),

              // Signup heading and description.
              const Text(
                "Create your Account",
                style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              const Text(
                "Join thousands of home cooks discovering new\nfavorites every day.",
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.grey),
              ),

              const SizedBox(height: 32),

              // Full name field.
              const AuthLabel(leftText: "Full Name", rightText: "Required"),
              AuthTextField(
                controller: _nameController,
                hintText: "XYZ",
                prefixIcon: Icons.person_outline,
                suffixIcon: const Icon(
                  Icons.check_circle_outline,
                  color: Colors.green,
                ),
              ),

              const SizedBox(height: 16),

              // Email field.
              const AuthLabel(
                leftText: "Email Address",
                rightText: "We don't spam",
              ),
              AuthTextField(
                controller: _emailController,
                hintText: "xyz@example.com",
                prefixIcon: Icons.email_outlined,
                suffixIcon: const Icon(
                  Icons.check_circle_outline,
                  color: Colors.green,
                ),
              ),

              const SizedBox(height: 16),

              // Password label and current strength.
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    "Password",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
                  ),
                  Row(
                    children: [
                      Icon(
                        Icons.shield_outlined,
                        color: _strengthColor,
                        size: 14,
                      ),
                      const SizedBox(width: 4),
                      Text(
                        _strengthLabel,
                        style: TextStyle(
                          color: _strengthColor,
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ],
              ),

              const SizedBox(height: 8),

              // Password field with a show/hide button.
              AuthTextField(
                controller: _passwordController,
                hintText: "MealMate@123",
                prefixIcon: Icons.lock_outline,
                obscureText: _obscurePassword,

                // Changes password visibility when the eye icon is tapped.
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

              const SizedBox(height: 8),

              // Visual indicator showing password strength.
              PasswordStrengthBar(
                strengthLevel: _strengthLevel,
                strengthColor: _strengthColor,
              ),

              const SizedBox(height: 8),

              // Information displayed below the password field.
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    "Contains letters, numbers & symbols",
                    style: TextStyle(color: Colors.grey, fontSize: 12),
                  ),
                  Text(
                    "PROTECTED",
                    style: TextStyle(
                      color: _strengthColor,
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),

              // Displays an error only when an error message exists.
              if (errorMessage.isNotEmpty) ...[
                const SizedBox(height: 12),
                Text(errorMessage, style: const TextStyle(color: Colors.red)),
              ],

              const SizedBox(height: 24),

              // Dietary preferences heading.
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: const [
                  Text(
                    "Dietary Preferences",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                  ),
                  Text(
                    "Tap to customize",
                    style: TextStyle(color: Colors.grey, fontSize: 12),
                  ),
                ],
              ),

              const SizedBox(height: 4),

              const Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "Tailor your daily recipe stream immediately:",
                  style: TextStyle(color: Colors.grey, fontSize: 12),
                ),
              ),

              const SizedBox(height: 12),

              // Displays selectable dietary preference chips.
              Wrap(
                spacing: 8,
                runSpacing: 8,
                children: [
                  DietChip(
                    label: "No Restrictions",
                    icon: Icons.restaurant_menu,
                    isSelected: _selectedDiet == "No Restrictions",
                    onTap: () =>
                        setState(() => _selectedDiet = "No Restrictions"),
                  ),
                  DietChip(
                    label: "Vegetarian",
                    icon: Icons.eco_outlined,
                    isSelected: _selectedDiet == "Vegetarian",
                    onTap: () => setState(() => _selectedDiet = "Vegetarian"),
                  ),
                  DietChip(
                    label: "Gluten-Free",
                    icon: Icons.grass,
                    isSelected: _selectedDiet == "Gluten-Free",
                    onTap: () => setState(() => _selectedDiet = "Gluten-Free"),
                  ),
                  DietChip(
                    label: "Halal",
                    icon: Icons.done_all,
                    isSelected: _selectedDiet == "Halal",
                    onTap: () => setState(() => _selectedDiet = "Halal"),
                  ),
                  DietChip(
                    label: "Keto",
                    icon: Icons.fastfood_outlined,
                    isSelected: _selectedDiet == "Keto",
                    onTap: () => setState(() => _selectedDiet = "Keto"),
                  ),
                ],
              ),

              const SizedBox(height: 24),

              TermsCheckboxRow(
                agreedToTerms: _agreedToTerms,
                onTap: () => setState(() => _agreedToTerms = !_agreedToTerms),
              ),

              const SizedBox(height: 24),

              PrimaryButton(text: "Create Account", onPressed: signUp),

              const SizedBox(height: 16),

              const GuaranteeBox(),

              const SizedBox(height: 24),

              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    "Already have an account? ",
                    style: TextStyle(color: Colors.grey),
                  ),
                  GestureDetector(
                    onTap: () => Navigator.pop(context),
                    child: const Text(
                      "Log In",
                      style: TextStyle(
                        color: Color(0xFFD94A38),
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 16),

              // Displays the API information footer.
              const ApiFooterInfo(),

              const SizedBox(height: 40),
            ],
          ),
        ),
      ),
    );
  }
}
