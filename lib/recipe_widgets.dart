import 'package:flutter/material.dart';

// Displays a small tag with an icon and a label.
class FloatingTag extends StatelessWidget {
  final IconData icon;
  final String label;

  const FloatingTag({
    super.key,
    required this.icon,
    required this.label,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),

      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.1),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),

      // Places the icon and label horizontally.
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 14, color: Colors.orange),
          const SizedBox(width: 4),
          Text(
            label,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 12,
            ),
          ),
        ],
      ),
    );
  }
}

// Displays a small label such as Chicken, Dinner, or High Protein.
class RecipeChip extends StatelessWidget {
  final String label;
  const RecipeChip({super.key, required this.label});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: Colors.grey.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Text(
        label,
        style: const TextStyle(
          fontSize: 12,
          color: Colors.black87,
        ),
      ),
    );
  }
}

// Displays a recipe statistic with an icon, heading, and value.
class StatBox extends StatelessWidget {
  final IconData icon;
  final String title;
  final String value;

  const StatBox({
    super.key,
    required this.icon,
    required this.title,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    // Arranges the icon, title, and value vertically.
    return Column(
      children: [
        Icon(icon, color: const Color(0xFFD94A38)),
        const SizedBox(height: 4),

        Text(
          title,
          style: const TextStyle(fontSize: 10, color: Colors.grey),
        ),

        const SizedBox(height: 2),

        Text(
          value,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 12,
          ),
        ),
      ],
    );
  }
}

// Displays one numbered cooking instruction.
class StepCard extends StatelessWidget {
  final int num;
  final String title;
  final String desc;

  const StepCard({
    super.key,
    required this.num,
    required this.title,
    required this.desc,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),

      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Circular badge containing the step number.
          CircleAvatar(
            backgroundColor: const Color(0xFFD94A38),
            radius: 12,
            child: Text(
              num.toString(),
              style: const TextStyle(
                color: Colors.white,
                fontSize: 12,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),

          const SizedBox(width: 12),

          // Allows the instruction to use the remaining width.
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                  ),
                ),

                const SizedBox(height: 4),

                Text(
                  desc,
                  style: const TextStyle(
                    color: Colors.black54,
                    fontSize: 12,
                    height: 1.4,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// Displays an ingredient, its quantity, and a checkbox.
class IngredientRow extends StatelessWidget {
  final String ingredient;
  final String amount;
  final bool isChecked;
  final VoidCallback onTap;

  const IngredientRow({
    super.key,
    required this.ingredient,
    required this.amount,
    required this.isChecked,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    // Detects taps anywhere on the ingredient row.
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.only(bottom: 8),
        padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 4),

        // Places the checkbox, ingredient name, and amount horizontally.
        child: Row(
          children: [
            // Creates the checkbox using a decorated container.
            Container(
              width: 16,
              height: 16,
              decoration: BoxDecoration(
                border: Border.all(
                  color: isChecked
                      ? const Color(0xFFD94A38)
                      : Colors.grey,
                ),
                borderRadius: BorderRadius.circular(4),
                color: isChecked
                    ? const Color(0xFFD94A38)
                    : Colors.transparent,
              ),

              // Shows a check icon only when the ingredient is checked.
              child: isChecked
                  ? const Icon(
                Icons.check,
                size: 12,
                color: Colors.white,
              )
                  : null,
            ),

            const SizedBox(width: 12),

            // Displays the ingredient name using available space.
            Expanded(
              child: Text(
                ingredient,
                style: TextStyle(
                  fontSize: 14,

                  // Crosses out the ingredient when checked.
                  decoration: isChecked
                      ? TextDecoration.lineThrough
                      : null,

                  color: isChecked ? Colors.grey : Colors.black87,
                ),
              ),
            ),

            // Displays the ingredient quantity.
            Text(
              amount,
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.bold,
                decoration: isChecked
                    ? TextDecoration.lineThrough
                    : null,
                color: isChecked
                    ? Colors.grey
                    : const Color(0xFFD94A38),
              ),
            ),
          ],
        ),
      ),
    );
  }
}