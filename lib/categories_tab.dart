import 'package:flutter/material.dart';
import 'models.dart';
import 'widgets.dart';
import 'api_service.dart';
import 'category_results.dart';

// Displays food categories and allows users to filter them.
class CategoriesTab extends StatefulWidget {
  final VoidCallback? onNavigateToSearch;

  const CategoriesTab({super.key, this.onNavigateToSearch});

  @override
  State<CategoriesTab> createState() => _CategoriesTabState();
}

// Manages category data, loading status, and selected filters.
class _CategoriesTabState extends State<CategoriesTab> {
  List<Category> _categories = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  // Retrieves categories from the API.
  void _loadData() async {
    try {
      final cats = await ApiService.getCategories();

      if (mounted) {
        setState(() {
          _categories = cats;
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
  String _selectedFilter = "All";

  @override
  Widget build(BuildContext context) {
    // Keeps categories matching the search text and selected filter.
    List<Category> filteredCategories = _categories.where((c) {
      bool matchesSearch = c.name.toLowerCase().contains(
        _searchQuery.toLowerCase(),
      );

      bool matchesFilter =
          _selectedFilter == "All" || c.name.toLowerCase().contains(
                _selectedFilter.toLowerCase(),
              ) || (_selectedFilter == "Meat & Poultry" &&
                  (c.name == "Chicken" || c.name == "Beef"));
      return matchesSearch && matchesFilter;
    }).toList();
    return Scaffold(
      backgroundColor: const Color(0xFFFAF9F6),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const MealMateHeader(),

            // Shows the page title and filter icon.
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    "Categories",
                    style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 22,
                    ),
                  ),

                  // Displays a filter icon inside a rounded container.
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 10,
                      vertical: 6,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.grey.withValues(alpha: 0.1),
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: const Icon(
                      Icons.filter_list,
                      color: Colors.black,
                      size: 16,
                    ),
                  ),
                ],
              ),
            ),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.0),
              child: Text(
                "Discover recipes by cuisine and meal type",
                style: TextStyle(color: Colors.grey, fontSize: 12),
              ),
            ),

            // Search field that navigates to the Search tab when tapped.
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: TextField(
                readOnly: true,
                onTap: () {
                  if (widget.onNavigateToSearch != null) {
                    widget.onNavigateToSearch!();
                  }
                },
                decoration: InputDecoration(
                  hintText: "Search categories...",
                  hintStyle: const TextStyle(
                    fontSize: 12,
                    color: Colors.grey,
                  ),
                  prefixIcon: const Icon(
                    Icons.search,
                    color: Colors.grey,
                  ),
                  filled: true,
                  fillColor: Colors.white,

                  // Defines the field's normal border.
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(16),
                    borderSide: BorderSide(
                      color: Colors.grey.withValues(alpha: 0.2),
                    ),
                  ),

                  // Defines the border when the field is not focused.
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(16),
                    borderSide: BorderSide(
                      color: Colors.grey.withValues(alpha: 0.2),
                    ),
                  ),
                ),
              ),
            ),

            // Allows users to scroll horizontally through filter chips.
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                children: [
                  _buildFilterChip("All", Icons.apps),
                  const SizedBox(width: 8),
                  _buildFilterChip("Meat & Poultry", Icons.kebab_dining),
                  const SizedBox(width: 8),
                  _buildFilterChip("Seafood", Icons.set_meal),
                  const SizedBox(width: 8),
                  _buildFilterChip("Vegetarian", Icons.grass),
                ],
              ),
            ),

            const SizedBox(height: 16),

            // Displays a loader or the filtered category cards.
            Expanded(
              child: _isLoading
                  ? const Center(
                child: CircularProgressIndicator(),
              )
                  : GridView.builder(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                gridDelegate:
                const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 16,
                  mainAxisSpacing: 16,
                  childAspectRatio: 0.85,
                ),
                itemCount: filteredCategories.length,
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () {
                      // Opens the selected category's recipe page.
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => CategoryResultsPage(
                            category: filteredCategories[index],
                          ),
                        ),
                      );
                    },

                    // Displays a category image with a dark overlay.
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(16),
                        image: DecorationImage(
                          image: NetworkImage(
                            filteredCategories[index].imageUrl,
                          ),
                          fit: BoxFit.cover,
                          colorFilter: ColorFilter.mode(
                            Colors.black.withValues(alpha: 0.4),
                            BlendMode.darken,
                          ),
                        ),
                      ),

                      // Places category details in the center of the card.
                      child: Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              filteredCategories[index].name,
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),

                            const SizedBox(height: 4),

                            Text(
                              filteredCategories[index].recipeCount,
                              style: const TextStyle(
                                color: Colors.white70,
                                fontSize: 10,
                              ),
                            ),

                            const SizedBox(height: 8),

                            const Text(
                              "Explore →",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 10,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Creates a selectable chip with an icon and label.
  Widget _buildFilterChip(String label, IconData icon) {
    bool isSelected = _selectedFilter == label;
    return GestureDetector(
      onTap: () {
        setState(() {
          _selectedFilter = label;
        });
      },

      child: Container(
        padding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 8,
        ),

        decoration: BoxDecoration(
          color: isSelected
              ? const Color(0xFFD94A38)
              : Colors.white,

          borderRadius: BorderRadius.circular(20),

          border: Border.all(
            color: isSelected
                ? const Color(0xFFD94A38)
                : Colors.grey.withValues(alpha: 0.3),
          ),
        ),

        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (isSelected)
              const Icon(
                Icons.check,
                size: 14,
                color: Colors.white,
              )
            else
              Icon(
                icon,
                size: 14,
                color: Colors.grey,
              ),

            const SizedBox(width: 4),

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