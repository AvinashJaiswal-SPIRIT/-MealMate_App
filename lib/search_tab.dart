import 'package:flutter/material.dart'; // Provides Flutter UI widgets.

import 'models.dart';
import 'widgets.dart';
import 'api_service.dart';
import 'recipe_detail.dart';

class SearchTab extends StatefulWidget {
  const SearchTab({super.key});

  @override
  State<SearchTab> createState() => _SearchTabState();
}

class _SearchTabState extends State<SearchTab> {
  List<Recipe> _recipes = [];
  bool _isLoading = false;
  String _searchQuery = "";

  // Controls the search input field.
  final TextEditingController _controller = TextEditingController();

  // Stores the currently selected filter.
  String _selectedFilter = "All Cuisines";

  @override
  void dispose() {
    // Releases the controller's resources when the screen is removed.
    _controller.dispose();
    super.dispose();
  }

  // Searches for recipes using the API.
  void _performSearch(String value) async {

    if (value.isEmpty) {
      if (mounted) {
        setState(() {
          _recipes = [];
        });
      }
      return;
    }

    // Starts loading and stores the submitted search text.
    if (mounted) {
      setState(() {
        _isLoading = true;
        _searchQuery = value;
      });
    }

    try {
      final res = await ApiService.searchMeals(value);

      if (mounted) {
        setState(() {
          _recipes = res;
          _isLoading = false;
        });
      }
    } catch (e) {
      if (mounted) {
        setState(() => _isLoading = false);
      }
    }
  }

  @override
  Widget build(BuildContext context) {

    List<Recipe> filteredRecipes = _recipes.where((r) {
      bool matchesSearch =
          _searchQuery.isEmpty ||
          r.title.toLowerCase().contains(_searchQuery.toLowerCase()) ||
          r.ingredients.any(
            (i) => i.toLowerCase().contains(_searchQuery.toLowerCase()),
          );

      // Checks whether the recipe matches the selected filter.
      bool matchesFilter =
          _selectedFilter == "All Cuisines" ||
          (_selectedFilter == "Italian" &&
              r.category.toLowerCase().contains("italian")) ||
          (_selectedFilter == "< 30 mins" &&
              r.time.contains(RegExp(r'1\d|2\d'))) ||
          (_selectedFilter == "Easy Prep" &&
              r.category.toLowerCase().contains("easy"));

      return matchesSearch && matchesFilter;
    }).toList();

    // Builds the search screen.
    return Scaffold(
      backgroundColor: const Color(0xFFFAF9F6),

      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // MealMate header.
            const MealMateHeader(),

            // Search input field.
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 16.0,
                vertical: 8.0,
              ),
              child: TextField(
                controller: _controller,

                onSubmitted: _performSearch,

                onChanged: (val) {
                  setState(() {
                    _searchQuery = val.trim();
                  });
                },

                decoration: InputDecoration(
                  hintText: "Search...",

                  prefixIcon: const Icon(Icons.search, color: Colors.grey),

                  suffixIcon: _searchQuery.isNotEmpty
                      ? IconButton(
                          icon: const Icon(
                            Icons.close,
                            color: Colors.grey,
                            size: 20,
                          ),

                          // Clears the input and stored search results.
                          onPressed: () {
                            _controller.clear();
                            setState(() {
                              _searchQuery = "";
                              _recipes = [];
                            });
                          },
                        )
                      : null,

                  // Styles the search field.
                  filled: true,
                  fillColor: Colors.grey.withValues(alpha: 0.1),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(24),
                    borderSide: BorderSide.none,
                  ),
                  contentPadding: const EdgeInsets.symmetric(vertical: 0),
                ),
              ),
            ),

            // Horizontally scrollable filter chips.
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                children: [
                  _buildFilterChip("All Cuisines", Icons.grid_view),
                  const SizedBox(width: 8),

                  _buildFilterChip("Italian", Icons.restaurant_menu),
                  const SizedBox(width: 8),

                  _buildFilterChip("< 30 mins", Icons.timer_outlined),
                  const SizedBox(width: 8),

                  _buildFilterChip("Easy Prep", Icons.bolt),
                ],
              ),
            ),

            // Displays the results heading and result count.
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Changes the heading according to the search query.
                      Text(
                        _searchQuery.isEmpty
                            ? "All Recipes"
                            : "Results for '$_searchQuery'",
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                        ),
                      ),

                      // Shows the number of matching recipes.
                      Text(
                        "${filteredRecipes.length} comforting recipes found",
                        style: const TextStyle(
                          color: Colors.grey,
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),

                  // Popularity label.
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 6,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.red.withValues(alpha: 0.1),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Row(
                      children: const [
                        Icon(
                          Icons.trending_up,
                          color: Color(0xFFD94A38),
                          size: 14,
                        ),
                        SizedBox(width: 4),
                        Text(
                          "Most Popular",
                          style: TextStyle(
                            color: Color(0xFFD94A38),
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            // Displays a loading indicator or the recipe list.
            Expanded(
              child: _isLoading
                  ? const Center(child: CircularProgressIndicator())
                  : ListView.builder(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      itemCount: filteredRecipes.length,

                      itemBuilder: (context, index) {
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
            ),
          ],
        ),
      ),
    );
  }

  // Creates a reusable filter chip.
  Widget _buildFilterChip(String label, IconData icon) {
    bool isSelected = _selectedFilter == label;

    return GestureDetector(
      onTap: () => setState(() => _selectedFilter = label),

      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),

        decoration: BoxDecoration(
          color: isSelected ? const Color(0xFFD94A38) : Colors.white,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: isSelected
                ? const Color(0xFFD94A38)
                : Colors.grey.withValues(alpha: 0.3),
          ),
        ),

        // Displays the filter icon and label.
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              icon,
              size: 16,
              color: isSelected ? Colors.white : Colors.grey,
            ),
            const SizedBox(width: 6),

            Text(
              label,
              style: TextStyle(
                color: isSelected ? Colors.white : Colors.black87,
                fontWeight: FontWeight.bold,
                fontSize: 12,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
