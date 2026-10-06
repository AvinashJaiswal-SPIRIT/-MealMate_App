import 'package:flutter/material.dart';
import 'login_widgets.dart';

class SignupLogo extends StatelessWidget {
  const SignupLogo({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 4,
            spreadRadius: 2,
          ),
        ],
      ),
      child: Image.asset(
        'assets/logo/meal_logo.png',
        width: 45,
        height: 45,
      ),
    );
  }
}

class ActiveCooks extends StatelessWidget {
  const ActiveCooks({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 12,
        vertical: 5,
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
      ),
      child: const Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            Icons.circle,
            color: Colors.green,
            size: 7,
          ),
          SizedBox(width: 5),
          Text(
            '24,800+ active home cooks',
            style: TextStyle(fontSize: 9),
          ),
        ],
      ),
    );
  }
}

class DietChip extends StatelessWidget {
  final String text;
  final bool selected;
  final VoidCallback onTap;

  const DietChip({
    super.key,
    required this.text,
    required this.selected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(
          horizontal: 11,
          vertical: 7,
        ),
        decoration: BoxDecoration(
          color: selected
              ? const Color(0xFFB82E1D)
              : const Color(0xFFF0E7E7),
          borderRadius: BorderRadius.circular(20),
        ),
        child: Text(
          text,
          style: TextStyle(
            fontSize: 9,
            color: selected ? Colors.white : Colors.black87,
          ),
        ),
      ),
    );
  }
}

class GuaranteeCard extends StatelessWidget {
  const GuaranteeCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.5),
        borderRadius: BorderRadius.circular(10),
      ),
      child: const Row(
        children: [
          CircleAvatar(
            radius: 13,
            backgroundColor: Color(0xFFFFB74D),
            child: Icon(
              Icons.card_giftcard,
              size: 15,
              color: Colors.white,
            ),
          ),
          SizedBox(width: 8),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Free Forever Guarantee',
                  style: TextStyle(fontSize: 9),
                ),
                Text(
                  'No hidden fees, ever.',
                  style: TextStyle(
                    fontSize: 8,
                    color: Colors.black54,
                  ),
                ),
              ],
            ),
          ),
          Text(
            '🔒 Encrypted',
            style: TextStyle(
              fontSize: 8,
              color: Colors.green,
            ),
          ),
        ],
      ),
    );
  }
}

