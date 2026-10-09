import 'package:flutter/material.dart';

import 'models.dart';

class PrimaryButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final IconData? icon;

  const PrimaryButton({
    super.key,
    required this.text,
    required this.onPressed,
    this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: const Color(0xFFD94A38),
        foregroundColor: Colors.white,
        minimumSize: const Size(double.infinity, 50),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
      ),

      onPressed: onPressed,

      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Shows the icon only when one is provided.
          if (icon != null) ...[Icon(icon), const SizedBox(width: 8)],

          Text(
            text,
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }
}

// Recipe card that supports horizontal and vertical layouts.
class RecipeCard extends StatefulWidget {
  final Recipe recipe;
  final VoidCallback onTap;
  final bool isHorizontal;

  const RecipeCard({
    super.key,
    required this.recipe,
    required this.onTap,
    this.isHorizontal = false,
  });

  @override
  State<RecipeCard> createState() => _RecipeCardState();
}

class _RecipeCardState extends State<RecipeCard> {
  // Adds or removes a recipe from the liked recipes list.
  void toggleLike() {
    setState(() {
      // Reverses the current like status.
      widget.recipe.isLiked = !widget.recipe.isLiked;

      if (widget.recipe.isLiked) {
        // Adds the recipe only if it is not already in the list.
        if (!globalLikedRecipes.contains(widget.recipe)) {
          globalLikedRecipes.add(widget.recipe);
        }
      } else {
        // Removes the recipe when it is unliked.
        globalLikedRecipes.remove(widget.recipe);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onTap,
      child: Container(
        // Width depends on the selected layout.
        width: widget.isHorizontal ? 180 : double.infinity,
        margin: const EdgeInsets.only(bottom: 16, right: 12),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withValues(alpha: 0.1),
              blurRadius: 10,
              offset: const Offset(0, 5),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            // Stack places the favorite button over the recipe image.
            Stack(
              children: [
                ClipRRect(
                  borderRadius: const BorderRadius.vertical(
                    top: Radius.circular(16),
                  ),
                  child: Image.network(
                    widget.recipe.imageUrl,
                    height: widget.isHorizontal ? 110 : 160,
                    width: double.infinity,
                    fit: BoxFit.cover,
                  ),
                ),

                // Favorite button positioned at the image's top-right.
                Positioned(
                  top: 8,
                  right: 8,
                  child: GestureDetector(
                    onTap: toggleLike,
                    child: CircleAvatar(
                      backgroundColor: Colors.white,
                      radius: 16,
                      child: Icon(
                        widget.recipe.isLiked
                            ? Icons.favorite
                            : Icons.favorite_border,
                        color: widget.recipe.isLiked
                            ? const Color(0xFFD94A38)
                            : Colors.grey,
                        size: 18,
                      ),
                    ),
                  ),
                ),
              ],
            ),

            // Displays the recipe name, cooking time, and rating.
            Padding(
              padding: const EdgeInsets.all(12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.recipe.title,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 14,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 6),
                  Row(
                    children: [
                      const Icon(
                        Icons.timer_outlined,
                        size: 14,
                        color: Colors.grey,
                      ),
                      const SizedBox(width: 4),
                      Text(
                        widget.recipe.time,
                        style: const TextStyle(
                          color: Colors.grey,
                          fontSize: 12,
                        ),
                      ),

                      // Pushes the rating to the right side.
                      const Spacer(),

                      const Icon(Icons.star, size: 14, color: Colors.orange),
                      const SizedBox(width: 4),
                      Text(
                        widget.recipe.rating.toString(),
                        style: const TextStyle(
                          color: Colors.grey,
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// Header showing the app logo, name, and profile image.
class MealMateHeader extends StatelessWidget {
  const MealMateHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // Logo and app name on the left.
          Row(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: Image.asset(
                  'assets/logo/app_logo.png',
                  width: 28,
                  height: 28,
                  fit: BoxFit.cover,
                ),
              ),
              const SizedBox(width: 8),
              const Text(
                "MealMate",
                style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
            ],
          ),

          // Profile image on the right.
          const CircleAvatar(
            backgroundColor: Colors.grey,
            radius: 16,
            backgroundImage: NetworkImage(
              'https://images.unsplash.com/photo-1633332755192-727a05c4013d?auto=format&fit=crop&w=150',
            ),
          ),
        ],
      ),
    );
  }
}

// Larger recipe card used for the liked recipes screen.
class LikedRecipeCard extends StatefulWidget {
  final Recipe recipe;
  final VoidCallback onTap;
  final VoidCallback onUnlike;

  const LikedRecipeCard({
    super.key,
    required this.recipe,
    required this.onTap,
    required this.onUnlike,
  });

  @override
  State<LikedRecipeCard> createState() => _LikedRecipeCardState();
}

class _LikedRecipeCardState extends State<LikedRecipeCard> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onTap,
      child: Container(
        margin: const EdgeInsets.only(bottom: 16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withValues(alpha: 0.1),
              blurRadius: 10,
              offset: const Offset(0, 5),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Recipe image with information displayed on top.
            Stack(
              children: [
                ClipRRect(
                  borderRadius: const BorderRadius.vertical(
                    top: Radius.circular(16),
                  ),
                  child: Image.network(
                    widget.recipe.imageUrl,
                    height: 180,
                    width: double.infinity,
                    fit: BoxFit.cover,
                  ),
                ),

                // Cooking time and rating badges.
                Positioned(
                  top: 12,
                  left: 12,
                  child: Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 8,
                          vertical: 4,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Row(
                          children: [
                            const Icon(
                              Icons.timer_outlined,
                              size: 12,
                              color: Colors.orange,
                            ),
                            const SizedBox(width: 4),
                            Text(
                              widget.recipe.time,
                              style: const TextStyle(
                                fontSize: 10,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(width: 8),
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 8,
                          vertical: 4,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Row(
                          children: [
                            const Icon(
                              Icons.star,
                              size: 12,
                              color: Colors.orange,
                            ),
                            const SizedBox(width: 4),
                            Text(
                              widget.recipe.rating.toString(),
                              style: const TextStyle(
                                fontSize: 10,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),

                // Favorite button calls the parent-provided function.
                Positioned(
                  top: 12,
                  right: 12,
                  child: GestureDetector(
                    onTap: widget.onUnlike,
                    child: const CircleAvatar(
                      backgroundColor: Colors.white,
                      radius: 16,
                      child: Icon(
                        Icons.favorite,
                        color: Color(0xFFD94A38),
                        size: 18,
                      ),
                    ),
                  ),
                ),

                // Category badge displayed at the bottom of the image.
                Positioned(
                  bottom: 12,
                  left: 12,
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 6,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.black.withValues(alpha: 0.6),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Text(
                      "${widget.recipe.category}  •  Curry",
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 10,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ],
            ),

            // Recipe details displayed below the image.
            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.recipe.title,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),

                  const SizedBox(height: 8),

                  // Small tags describing the recipe.
                  Row(
                    children: [
                      _buildTag(Icons.fitness_center, "High Protein"),
                      const SizedBox(width: 8),
                      _buildTag(Icons.child_care, "Kid Friendly"),
                      const SizedBox(width: 8),
                      _buildTag(
                        Icons.local_fire_department_outlined,
                        widget.recipe.calories,
                      ),
                    ],
                  ),

                  const SizedBox(height: 16),

                  // Ingredient count and Cook Now button.
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          const Icon(
                            Icons.restaurant,
                            size: 14,
                            color: Colors.green,
                          ),
                          const SizedBox(width: 4),
                          Text(
                            "${widget.recipe.ingredients.length} ingredients ready",
                            style: const TextStyle(
                              color: Colors.grey,
                              fontSize: 12,
                            ),
                          ),
                        ],
                      ),

                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFFD94A38),
                          foregroundColor: Colors.white,
                          padding: const EdgeInsets.symmetric(
                            horizontal: 16,
                            vertical: 0,
                          ),
                          minimumSize: const Size(100, 32),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16),
                          ),
                        ),

                        // Opens the recipe using the supplied callback.
                        onPressed: widget.onTap,

                        child: Row(
                          children: const [
                            Text(
                              "Cook Now",
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(width: 4),
                            Icon(Icons.arrow_forward, size: 14),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Builds a small tag to avoid repeating the same layout.
  Widget _buildTag(IconData icon, String label) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 4),
      decoration: BoxDecoration(
        color: const Color(0xFFD94A38).withValues(alpha: 0.05),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        children: [
          Icon(icon, size: 10, color: const Color(0xFFD94A38)),
          const SizedBox(width: 4),
          Text(
            label,
            style: const TextStyle(fontSize: 10, color: Colors.black87),
          ),
        ],
      ),
    );
  }
}
