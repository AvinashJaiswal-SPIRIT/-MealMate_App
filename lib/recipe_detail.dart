import 'package:flutter/material.dart';

import 'models.dart';
import 'recipe_widgets.dart';

// --- RECIPE DETAIL WIDGET ---
// Shows detailed view of a recipe, including ingredients, steps, and video tutorial.
class RecipeDetail extends StatefulWidget {
  final Recipe recipe;
  const RecipeDetail({super.key, required this.recipe});

  @override
  State<RecipeDetail> createState() => _RecipeDetailState();
}

class _RecipeDetailState extends State<RecipeDetail> {
  int _servings = 4;
  late List<bool> _checkedIngredients;
  final String _maleAvatar = 'https://images.unsplash.com/photo-1633332755192-727a05c4013d?auto=format&fit=crop&w=150';

  @override
  void initState() {
    super.initState();
    _checkedIngredients = List<bool>.filled(
      widget.recipe.ingredients.length,
      false,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFAF9F6),
      appBar: AppBar(
        backgroundColor: const Color(0xFFFAF9F6),
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.black),
        title: const Text(
          "Recipe Detail",
          style: TextStyle(
            color: Colors.black,
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: [
          IconButton(icon: const Icon(Icons.share_outlined), onPressed: () {}),
          IconButton(icon: const Icon(Icons.bookmark_border), onPressed: () {}),
          Padding(
            padding: const EdgeInsets.only(right: 16.0),
            child: CircleAvatar(
              radius: 12,
              backgroundImage: NetworkImage(_maleAvatar),
            ),
          ),
        ],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.only(bottom: 100),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Stack(
                clipBehavior: Clip.none,
                children: [
                  Image.network(
                    widget.recipe.imageUrl,
                    height: 250,
                    width: double.infinity,
                    fit: BoxFit.cover,
                  ),
                  Positioned(
                    bottom: -16,
                    left: 0,
                    right: 0,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        FloatingTag(
                          icon: Icons.timer_outlined,
                          label: widget.recipe.time,
                        ),
                        const SizedBox(width: 8),
                        const FloatingTag(icon: Icons.speed, label: "Easy"),
                        const SizedBox(width: 8),
                        FloatingTag(
                          icon: Icons.star,
                          label: widget.recipe.rating.toString(),
                        ),
                        const SizedBox(width: 8),
                        const FloatingTag(
                          icon: Icons.local_fire_department_outlined,
                          label: "540 kcal",
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 32),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.recipe.title,
                      style: const TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 4),
                    const Text(
                      "Authentic style recipe curated for you. Packed with flavor and easy to make at home.",
                      style: TextStyle(color: Colors.grey, fontSize: 12),
                    ),
                    const SizedBox(height: 16),
                    Wrap(
                      spacing: 8,
                      runSpacing: 8,
                      children: [
                        RecipeChip(label: widget.recipe.category),
                        const RecipeChip(label: "High Protein"),
                        const RecipeChip(label: "Dinner"),
                      ],
                    ),
                    const SizedBox(height: 16),
                    Row(
                      children: [
                        CircleAvatar(
                          radius: 16,
                          backgroundImage: NetworkImage(_maleAvatar),
                        ),
                        const SizedBox(width: 12),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: const [
                                Text(
                                  "Curated by Chef Anita",
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 12,
                                  ),
                                ),
                                SizedBox(width: 4),
                                Icon(
                                  Icons.verified,
                                  color: Colors.green,
                                  size: 12,
                                ),
                              ],
                            ),
                            const Text(
                              "Master Cuisine Specialist",
                              style: TextStyle(
                                color: Colors.grey,
                                fontSize: 10,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    const SizedBox(height: 24),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        StatBox(
                          icon: Icons.group_outlined,
                          title: "SERVINGS",
                          value: "$_servings ppl",
                        ),
                        const StatBox(
                          icon: Icons.hourglass_empty,
                          title: "PREP TIME",
                          value: "15m",
                        ),
                        const StatBox(
                          icon: Icons.outdoor_grill_outlined,
                          title: "COOK TIME",
                          value: "20m",
                        ),
                        const StatBox(
                          icon: Icons.trending_up,
                          title: "DIFFICULTY",
                          value: "Med",
                        ),
                      ],
                    ),
                    const SizedBox(height: 24),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            const Text(
                              "Ingredients",
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(width: 8),
                            Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 8,
                                vertical: 2,
                              ),
                              decoration: BoxDecoration(
                                color: Colors.grey.withValues(alpha: 0.2),
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: Text(
                                "${widget.recipe.ingredients.length} items",
                                style: const TextStyle(
                                  fontSize: 10,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ],
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 8,
                            vertical: 4,
                          ),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(16),
                            border: Border.all(
                              color: Colors.grey.withValues(alpha: 0.2),
                            ),
                          ),
                          child: Row(
                            children: [
                              GestureDetector(
                                onTap: () => setState(() {
                                  if (_servings > 1) _servings--;
                                }),
                                child: const Icon(Icons.remove, size: 14),
                              ),
                              const SizedBox(width: 8),
                              Text(
                                "$_servings",
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 12,
                                ),
                              ),
                              const SizedBox(width: 8),
                              GestureDetector(
                                onTap: () => setState(() {
                                  _servings++;
                                }),
                                child: const Icon(Icons.add, size: 14),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),
                    // --- INGREDIENTS LIST ---
                    // Generates rows for each ingredient with checkboxes
                    ...widget.recipe.ingredients.asMap().entries.map((entry) {
                      int idx = entry.key;
                      String ing = entry.value;
                      bool isChecked = _checkedIngredients[idx];
                      String amt = [
                        "600g",
                        "1 cup",
                        "2 tbsp",
                        "1 whole",
                        "3 cloves",
                        "400g",
                        "1/2 cup",
                        "Handful",
                      ][idx % 8];

                      return IngredientRow(
                        ingredient: ing,
                        amount: amt,
                        isChecked: isChecked,
                        onTap: () => setState(() {
                          _checkedIngredients[idx] = !isChecked;
                        }),
                      );
                    }),
                    const SizedBox(height: 24),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: const [
                        Text(
                          "Step-by-Step Instructions",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          "4 Steps",
                          style: TextStyle(color: Colors.grey, fontSize: 12),
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),
                    const StepCard(
                      num: 1,
                      title: "Prepare ingredients",
                      desc: "Chop all the vegetables and prepare the marinade for the main dish.",
                    ),
                    const StepCard(
                      num: 2,
                      title: "Cook the base",
                      desc: "Heat oil in a pan, add the aromatics and cook until golden brown.",
                    ),
                    const StepCard(
                      num: 3,
                      title: "Simmer and season",
                      desc: "Add the main ingredients and let it simmer until cooked thoroughly.",
                    ),
                    const SizedBox(height: 24),
                    const Text(
                      "Video Tutorial",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 12),
                    Container(
                      height: 150,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        image: const DecorationImage(
                          image: NetworkImage(
                            'https://images.unsplash.com/photo-1556910103-1c02745aae4d?auto=format&fit=crop&w=600',
                          ),
                          fit: BoxFit.cover,
                        ),
                      ),
                      child: const Center(
                        child: CircleAvatar(
                          backgroundColor: Color(0xFFD94A38),
                          radius: 24,
                          child: Icon(
                            Icons.play_arrow,
                            color: Colors.white,
                            size: 28,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: SafeArea(
        child: Container(
          color: const Color(0xFFFAF9F6),
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          child: Row(
            children: [
              GestureDetector(
                onTap: () {
                  setState(() {
                    widget.recipe.isLiked = !widget.recipe.isLiked;
                    if (widget.recipe.isLiked) {
                      if (!globalLikedRecipes.contains(widget.recipe)) {
                        globalLikedRecipes.add(widget.recipe);
                      }
                    } else {
                      globalLikedRecipes.remove(widget.recipe);
                    }
                  });
                },
                child: Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: widget.recipe.isLiked
                        ? Colors.red.withValues(alpha: 0.1)
                        : Colors.grey.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Icon(
                    widget.recipe.isLiked
                        ? Icons.favorite
                        : Icons.favorite_border,
                    color: widget.recipe.isLiked ? Colors.red : Colors.grey,
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFFD94A38),
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  onPressed: () {},
                  child: const Text(
                    "Start Cooking Mode",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
