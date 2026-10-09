import 'package:flutter/material.dart';
import 'models.dart';
import 'recipe_widgets.dart';
import 'api_service.dart';
import 'package:url_launcher/url_launcher.dart';

class RecipeDetail extends StatefulWidget {
  final Recipe recipe;
  const RecipeDetail({super.key, required this.recipe});

  @override
  State<RecipeDetail> createState() => _RecipeDetailState();
}

class _RecipeDetailState extends State<RecipeDetail> {
  int _servings = 4;
  late List<bool> _checkedIngredients;

  // URL of the profile avatar image.
  final String _maleAvatar =
      'https://images.unsplash.com/photo-1633332755192-727a05c4013d?auto=format&fit=crop&w=150';

  late Recipe _recipe;
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();

    _recipe = widget.recipe;

    // Creates one false value for each ingredient.
    _checkedIngredients = List<bool>.filled(
      _recipe.ingredients.length,
      false,
    );

    // Fetches complete details if the ingredient list is empty.
    if (_recipe.ingredients.isEmpty) {
      _fetchFullRecipe();
    }
  }

  // Fetches complete recipe details from the API.
  void _fetchFullRecipe() async {
    setState(() => _isLoading = true);

    try {

      final fullRecipe = await ApiService.getMealDetails(_recipe.id);

      if (fullRecipe != null && mounted) {
        setState(() {
          _recipe = fullRecipe;

          _checkedIngredients = List<bool>.filled(
            _recipe.ingredients.length,
            false,
          );

          _isLoading = false;
        });
      } else if (mounted) {
        setState(() => _isLoading = false);
      }
    } catch (e) {
      if (mounted) {
        setState(() => _isLoading = false);
      }
    }
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
          IconButton(
            icon: const Icon(Icons.share_outlined),
            onPressed: () {},
          ),

          IconButton(
            icon: const Icon(Icons.bookmark_border),
            onPressed: () {},
          ),

          // Displays the profile avatar.
          Padding(
            padding: const EdgeInsets.only(right: 16.0),
            child: CircleAvatar(
              radius: 12,
              backgroundImage: NetworkImage(_maleAvatar),
            ),
          ),
        ],
      ),

      // Shows a loader while fetching recipe details.
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.only(bottom: 100),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Stack(
                clipBehavior: Clip.none,
                children: [
                  Image.network(
                    _recipe.imageUrl,
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
                          label: _recipe.time,
                        ),
                        const SizedBox(width: 8),

                        const FloatingTag(
                          icon: Icons.speed,
                          label: "Easy",
                        ),
                        const SizedBox(width: 8),

                        FloatingTag(
                          icon: Icons.star,
                          label: _recipe.rating.toString(),
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

              // Adds horizontal padding around the recipe information.
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Recipe name.
                    Text(
                      _recipe.title,
                      style: const TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    const SizedBox(height: 4),

                    const Text(
                      "Authentic style recipe curated for you. Packed with flavor and easy to make at home.",
                      style: TextStyle(
                        color: Colors.grey,
                        fontSize: 12,
                      ),
                    ),

                    const SizedBox(height: 16),

                    Wrap(
                      spacing: 8,
                      runSpacing: 8,
                      children: [
                        RecipeChip(label: _recipe.category),
                        const RecipeChip(label: "High Protein"),
                        const RecipeChip(label: "Dinner"),
                      ],
                    ),

                    const SizedBox(height: 16),

                    // Displays chef information.
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

                    // Displays four recipe statistics.
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: StatBox(
                            icon: Icons.group_outlined,
                            title: "SERVINGS",
                            value: "$_servings ppl",
                          ),
                        ),
                        const Expanded(
                          child: StatBox(
                            icon: Icons.hourglass_empty,
                            title: "PREP TIME",
                            value: "15m",
                          ),
                        ),
                        const Expanded(
                          child: StatBox(
                            icon: Icons.outdoor_grill_outlined,
                            title: "COOK TIME",
                            value: "20m",
                          ),
                        ),
                        const Expanded(
                          child: StatBox(
                            icon: Icons.trending_up,
                            title: "DIFFICULTY",
                            value: "Med",
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 24),

                    // Ingredients heading and serving controls.
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

                            // Displays the number of ingredients.
                            Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 8,
                                vertical: 2,
                              ),
                              decoration: BoxDecoration(
                                color: Colors.grey.withValues(
                                  alpha: 0.2,
                                ),
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: Text(
                                "${_recipe.ingredients.length} items",
                                style: const TextStyle(
                                  fontSize: 10,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ],
                        ),

                        // Buttons for decreasing and increasing servings.
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
                                // Decreases servings but never below one.
                                onTap: () => setState(() {
                                  if (_servings > 1) _servings--;
                                }),
                                child: const Icon(
                                  Icons.remove,
                                  size: 14,
                                ),
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
                                // Increases the serving count.
                                onTap: () => setState(() {
                                  _servings++;
                                }),
                                child: const Icon(
                                  Icons.add,
                                  size: 14,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 12),

                    // Creates a row for every ingredient.
                    ..._recipe.ingredients.asMap().entries.map((entry) {
                      int idx = entry.key;
                      String raw = entry.value;

                      String ing = raw;
                      String amt = "";


                      if (raw.contains("|||")) {
                        final parts = raw.split("|||");
                        ing = parts[0];
                        amt = parts.length > 1 ? parts[1] : "";
                      }


                      bool isChecked = false;
                      if (idx < _checkedIngredients.length) {
                        isChecked = _checkedIngredients[idx];
                      }


                      return IngredientRow(
                        ingredient: ing,
                        amount: amt,
                        isChecked: isChecked,

                        // Toggles the checkbox when the row is tapped.
                        onTap: () => setState(() {
                          if (idx < _checkedIngredients.length) {
                            _checkedIngredients[idx] = !isChecked;
                          }
                        }),
                      );
                    }),

                    const SizedBox(height: 24),

                    // Instructions heading and total step count.
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          "Step-by-Step Instructions",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          "${_recipe.steps.length} Steps",
                          style: const TextStyle(
                            color: Colors.grey,
                            fontSize: 12,
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 12),

                    // Creates a numbered card for every instruction.
                    ..._recipe.steps.asMap().entries.map((entry) {
                      return StepCard(
                        num: entry.key + 1,
                        title: "Step",
                        desc: entry.value,
                      );
                    }),

                    // Displays the video section only if a URL exists.
                    if (_recipe.youtubeUrl.isNotEmpty) ...[
                      const SizedBox(height: 24),

                      const Text(
                        "Video Tutorial",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),

                      const SizedBox(height: 12),

                      // Opens the YouTube tutorial when tapped.
                      GestureDetector(
                        onTap: () async {
                          if (_recipe.youtubeUrl.isNotEmpty) {
                            final uri = Uri.parse(_recipe.youtubeUrl);

                            try {
                              // Attempts to open the URL externally.
                              if (!await launchUrl(
                                uri,
                                mode: LaunchMode.externalApplication,
                              )) {
                                throw 'Could not launch';
                              }
                            } catch (e) {
                              // Displays an error if the video cannot open.
                              if (mounted) {
                                ScaffoldMessenger.of(context)
                                    .showSnackBar(
                                  const SnackBar(
                                    content: Text(
                                      'Could not open video.',
                                    ),
                                  ),
                                );
                              }
                            }
                          }
                        },

                        // Video thumbnail with a play button.
                        child: Container(
                          height: 150,
                          width: double.infinity,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12),
                            image: DecorationImage(
                              image: NetworkImage(
                                _recipe.imageUrl.isNotEmpty
                                    ? _recipe.imageUrl
                                    : 'https://images.unsplash.com/photo-1556910103-1c02745aae4d?auto=format&fit=crop&w=600',
                              ),
                              fit: BoxFit.cover,
                              colorFilter: ColorFilter.mode(
                                Colors.black.withValues(alpha: 0.3),
                                BlendMode.darken,
                              ),
                            ),
                          ),
                          child: Center(
                            child: CircleAvatar(
                              backgroundColor: const Color(0xFFD94A38),
                              radius: 24,
                              child: const Icon(
                                Icons.play_arrow,
                                color: Colors.white,
                                size: 28,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ],
                ),
              ),
            ],
          ),
        ),
      ),

      // Places the bottom cooking action bar at the center of the bottom edge.
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,

      // Bottom action bar containing the favorite and cooking buttons.
      floatingActionButton: SafeArea(
        child: Container(
          color: const Color(0xFFFAF9F6),
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          child: Row(
            children: [
              // Favorite button.
              GestureDetector(
                onTap: () {
                  setState(() {
                    // Switches between liked and unliked.
                    _recipe.isLiked = !_recipe.isLiked;

                    if (_recipe.isLiked) {
                      // Adds the recipe only if it is not already in the list.
                      if (!globalLikedRecipes.contains(_recipe)) {
                        globalLikedRecipes.add(_recipe);
                      }
                    } else {
                      // Removes the recipe when it is unliked.
                      globalLikedRecipes.remove(_recipe);
                    }
                  });
                },
                child: Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: _recipe.isLiked
                        ? Colors.red.withValues(alpha: 0.1)
                        : Colors.grey.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Icon(
                    // Changes the heart icon according to the liked state.
                    _recipe.isLiked
                        ? Icons.favorite
                        : Icons.favorite_border,
                    color: _recipe.isLiked ? Colors.red : Colors.grey,
                  ),
                ),
              ),

              const SizedBox(width: 12),

              // Main cooking button.
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

                  // Button action has not been implemented yet.
                  onPressed: () {},

                  child: const Text(
                    "Start Cooking Mode",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
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