import 'package:flutter/material.dart';

import 'models.dart';
import 'widgets.dart';
import 'api_service.dart';
import 'recipe_detail.dart';
import 'category_results.dart';

class HomeTab extends StatefulWidget {
  final VoidCallback? onNavigateToSearch;
  final VoidCallback? onNavigateToCategories;
  const HomeTab({
    super.key,
    this.onNavigateToSearch,
    this.onNavigateToCategories,
  });

  @override
  State<HomeTab> createState() => _HomeTabState();
}

class _HomeTabState extends State<HomeTab> {
  List<Recipe> _recipes = [];
  List<Category> _categories = [];

  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  // Fetches categories and four random meals from the API.
  void _loadData() async {
    try {
      final cats = await ApiService.getCategories();

      final r1 = await ApiService.getRandomMeal();
      final r2 = await ApiService.getRandomMeal();
      final r3 = await ApiService.getRandomMeal();
      final r4 = await ApiService.getRandomMeal();

      List<Recipe> loadedRecipes = [];

      if (r1 != null) loadedRecipes.add(r1);
      if (r2 != null) loadedRecipes.add(r2);
      if (r3 != null) loadedRecipes.add(r3);
      if (r4 != null) loadedRecipes.add(r4);

      if (mounted) {

        setState(() {
          _categories = cats;
          _recipes = loadedRecipes;

          _isLoading = false;
        });
      }
    } catch (e) {

      if (mounted)
        setState(() {
          _isLoading = false;
        });
    }
  }

  final String _searchQuery = "";

  @override
  Widget build(BuildContext context) {
    List<Recipe> filteredRecipes = _recipes.where((r) {
      return r.title.toLowerCase().contains(_searchQuery.toLowerCase()) ||
          r.ingredients.any(
            (i) => i.toLowerCase().contains(_searchQuery.toLowerCase()),
          );
    }).toList();

    return Scaffold(
      backgroundColor: const Color(0xFFFAF9F6),
      body: SafeArea(
        child: _isLoading
            ? const Center(child: CircularProgressIndicator())

            : SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Reusable MealMate header widget.
                    const MealMateHeader(),
                    const Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: 16.0,
                        vertical: 8.0,
                      ),
                      child: Text(
                        "Good evening, Avi 👋",
                        style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 16.0),
                      child: Text(
                        "What are you craving today?",
                        style: TextStyle(color: Colors.grey, fontSize: 12),
                      ),
                    ),

                    // Search bar
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: TextField(
                        readOnly: true,
                        onTap: () {
                          if (widget.onNavigateToSearch != null) {
                            widget.onNavigateToSearch!();
                          }
                        },

                        // Configure the search field's appearance.
                        decoration: InputDecoration(
                          hintText:
                              "Search 300+ delicious recipes or ingred...",

                          hintStyle: const TextStyle(
                            fontSize: 12,
                            color: Colors.grey,
                          ),

                          // Search icon on the left.
                          prefixIcon: const Icon(
                            Icons.search,
                            color: Colors.grey,
                          ),

                          // Filter/settings icon on the right.
                          suffixIcon: Container(
                            margin: const EdgeInsets.all(8),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(8),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.withValues(alpha: 0.1),
                                  blurRadius: 4,
                                ),
                              ],
                            ),
                            child: const Icon(
                              Icons.tune,
                              color: Colors.grey,
                              size: 18,
                            ),
                          ),

                          // Give the field a white background.
                          filled: true,
                          fillColor: Colors.white,

                          // Configure the normal border.
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(16),
                            borderSide: BorderSide(
                              color: Colors.grey.withValues(alpha: 0.2),
                            ),
                          ),

                          // Configure the border when enabled.
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(16),
                            borderSide: BorderSide(
                              color: Colors.grey.withValues(alpha: 0.2),
                            ),
                          ),
                        ),
                      ),
                    ),

                    // If a search query exists, show search results.
                    if (_searchQuery.isNotEmpty) ...[
                      const Padding(
                        padding: EdgeInsets.symmetric(horizontal: 16.0),
                        child: Text(
                          "Search Results",
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),

                      // Show a message if there are no matches.
                      filteredRecipes.isEmpty
                          ? const Padding(
                              padding: EdgeInsets.all(16),
                              child: Text("No recipes found."),
                            )
                          : ListView.builder(
                              physics: const NeverScrollableScrollPhysics(),
                              shrinkWrap: true,
                              padding: const EdgeInsets.all(16),
                              itemCount: filteredRecipes.length,
                              itemBuilder: (context, index) {
                                // Create a card for each matching recipe.
                                return RecipeCard(
                                  recipe: filteredRecipes[index],
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => RecipeDetail(
                                          recipe: filteredRecipes[index],
                                        ),
                                      ),
                                    );
                                  },
                                );
                              },
                            ),
                    ] else ...[
                      // Display the Popular Recipes heading and See all.
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text(
                              "Popular Recipes",
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),

                            const Text(
                              "See all →",
                              style: TextStyle(
                                color: Color(0xFFD94A38),
                                fontSize: 12,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const Padding(
                        padding: EdgeInsets.symmetric(horizontal: 16.0),
                        child: Text(
                          "Trending dishes in your community",
                          style: TextStyle(color: Colors.grey, fontSize: 10),
                        ),
                      ),

                      // Horizontally scrollable popular recipe cards.
                      SizedBox(
                        height: 230,
                        child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          padding: const EdgeInsets.all(16),

                          itemCount: _recipes.length,

                          itemBuilder: (context, index) {
                            return RecipeCard(
                              recipe: _recipes[index],

                              isHorizontal: true,
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        RecipeDetail(recipe: _recipes[index]),
                                  ),
                                );
                              },
                            );
                          },
                        ),
                      ),

                      const Padding(
                        padding: EdgeInsets.symmetric(horizontal: 16.0),
                        child: Text(
                          "Explore Categories",
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),

                      const Padding(
                        padding: EdgeInsets.symmetric(horizontal: 16.0),
                        child: Text(
                          "Find delicious meals by your favorite ingredient",
                          style: TextStyle(color: Colors.grey, fontSize: 10),
                        ),
                      ),

                      // Horizontally scrollable category chips.
                      SizedBox(
                        height: 60,
                        child: ListView.builder(
                          scrollDirection: Axis.horizontal,

                          padding: const EdgeInsets.symmetric(
                            horizontal: 16,
                            vertical: 12,
                          ),

                          itemCount: _categories.length,

                          itemBuilder: (context, index) {
                            return GestureDetector(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => CategoryResultsPage(
                                      category: _categories[index],
                                      onNavigateToCategories:
                                          widget.onNavigateToCategories,
                                    ),
                                  ),
                                );
                              },

                              child: Container(
                                margin: const EdgeInsets.only(right: 8),

                                padding: const EdgeInsets.symmetric(
                                  horizontal: 16,
                                  vertical: 8,
                                ),
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(20),
                                  border: Border.all(
                                    color: Colors.grey.withValues(alpha: 0.2),
                                  ),
                                ),

                                child: Row(
                                  children: [
                                    CircleAvatar(
                                      radius: 10,
                                      backgroundImage: NetworkImage(
                                        _categories[index].imageUrl,
                                      ),
                                    ),

                                    const SizedBox(width: 8),
                                    Text(
                                      _categories[index].name,
                                      style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 12,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          },
                        ),
                      ),

                      // Kitchen Inspiration section with padding.
                      Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 8,
                        ),
                        child: Container(
                          padding: const EdgeInsets.all(16),
                          decoration: BoxDecoration(
                            color: const Color(0xFFF9EFE9),
                            borderRadius: BorderRadius.circular(16),
                          ),

                          child: Row(
                            children: [
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      children: const [
                                        Icon(
                                          Icons.lightbulb_outline,
                                          size: 14,
                                          color: Color(0xFFD94A38),
                                        ),
                                        SizedBox(width: 4),
                                        Text(
                                          "Kitchen Inspiration",
                                          style: TextStyle(
                                            color: Color(0xFFD94A38),
                                            fontSize: 10,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ],
                                    ),

                                    const SizedBox(height: 8),

                                    const Text(
                                      "Don't know what to cook?",
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16,
                                      ),
                                    ),

                                    const SizedBox(height: 4),

                                    const Text(
                                      "Let MealMate pick a delicious surprise\nrecipe from TheMealDB!",
                                      style: TextStyle(
                                        fontSize: 10,
                                        color: Colors.black54,
                                      ),
                                    ),

                                    const SizedBox(height: 12),

                                    ElevatedButton.icon(
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor: const Color(
                                          0xFFD94A38,
                                        ),
                                        foregroundColor: Colors.white,
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(
                                            20,
                                          ),
                                        ),
                                      ),

                                      // Runs when the button is tapped.
                                      onPressed: () async {

                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(
                                              const SnackBar(
                                                content: Text(
                                                  "Finding a surprise meal...",
                                                ),
                                                duration: Duration(
                                                  milliseconds: 500,
                                                ),
                                              ),
                                            );

                                        // Request one random meal.
                                        final randomRecipe =
                                            await ApiService.getRandomMeal();

                                        if (randomRecipe != null && mounted) {
                                          // Open its detail page.
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) =>
                                                  RecipeDetail(
                                                    recipe: randomRecipe,
                                                  ),
                                            ),
                                          );
                                        }
                                      },

                                      // Icon shown before the button label.
                                      icon: const Icon(Icons.casino, size: 16),

                                      // Text displayed on the button.
                                      label: const Text(
                                        "Surprise Me \u{2728}",
                                        style: TextStyle(
                                          fontSize: 12,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),

                              // Decorative casino/dice icon.
                              const Icon(
                                Icons.casino,
                                size: 40,
                                color: Colors.orangeAccent,
                              ),
                            ],
                          ),
                        ),
                      ),

                      // Recommended recipes heading and Refine label.
                      const Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: 16.0,
                          vertical: 8.0,
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Recommended for You",
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              "Refine \u{2630}",
                              style: TextStyle(
                                color: Colors.grey,
                                fontSize: 10,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const Padding(
                        padding: EdgeInsets.symmetric(horizontal: 16.0),
                        child: Text(
                          "Personalized picks based on your taste",
                          style: TextStyle(color: Colors.grey, fontSize: 10),
                        ),
                      ),

                      const SizedBox(height: 8),

                      // Display recommended recipes in a two-column grid.
                      GridView.builder(
                        physics: const NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        padding: const EdgeInsets.symmetric(horizontal: 16),

                        // Configure the grid's layout.
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                              childAspectRatio:
                                  0.75,
                              crossAxisSpacing: 12,
                              mainAxisSpacing: 12,
                            ),

                        itemCount: _recipes.length,

                        // Build each recipe card.
                        itemBuilder: (context, index) {
                          return RecipeCard(
                            recipe: _recipes[index],

                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>
                                      RecipeDetail(recipe: _recipes[index]),
                                ),
                              );
                            },
                          );
                        },
                      ),

                      // Space at the bottom of the screen.
                      const SizedBox(height: 24),
                    ],
                  ],
                ),
              ),
      ),
    );
  }
}
