import 'package:flutter/material.dart';

import 'models.dart';
import 'widgets.dart';
import 'api_service.dart';
import 'recipe_detail.dart';

class CategoryResultsPage extends StatefulWidget {
  final Category category;
  final VoidCallback? onNavigateToCategories;

  const CategoryResultsPage({
    super.key,
    required this.category,
    this.onNavigateToCategories,
  });

  @override
  State<CategoryResultsPage> createState() => _CategoryResultsPageState();
}

class _CategoryResultsPageState extends State<CategoryResultsPage> {
  List<Recipe> _recipes = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  void _loadData() async {
    try {
      final response = await ApiService.getMealsByCategory(widget.category.name);
      if (mounted) {
        setState(() {
          _recipes = response;
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

  String _selectedFilter = "All";

  @override
  Widget build(BuildContext context) {
    List<Recipe> filteredRecipes = _recipes
        .where(
          (r) =>
              r.category.toLowerCase() == widget.category.name.toLowerCase() ||
              _selectedFilter == "All",
        )
        .toList();
    if (filteredRecipes.isEmpty) {
      filteredRecipes = _recipes;
    }

    return Scaffold(
      backgroundColor: const Color(0xFFFAF9F6),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.black),
        title: const Text(
          "Category Results",
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
            fontSize: 16,
          ),
        ),
        centerTitle: true,
        actions: [
          IconButton(icon: const Icon(Icons.share_outlined), onPressed: () {}),
          IconButton(icon: const Icon(Icons.bookmark_border), onPressed: () {}),
          const CircleAvatar(
            radius: 14,
            backgroundImage: NetworkImage(
              'https://images.unsplash.com/photo-1633332755192-727a05c4013d?auto=format&fit=crop&w=150',
            ),
          ),
          const SizedBox(width: 16),
        ],
      ),
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Stack(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(16),
                    child: Image.network(
                      widget.category.imageUrl,
                      height: 140,
                      width: double.infinity,
                      fit: BoxFit.cover,
                    ),
                  ),
                  Container(
                    height: 140,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(16),
                      color: Colors.black.withValues(alpha: 0.4),
                    ),
                  ),
                  Positioned(
                    bottom: 16,
                    left: 16,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 8,
                            vertical: 4,
                          ),
                          decoration: BoxDecoration(
                            color: const Color(0xFFD94A38),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Text(
                            "Category: ${widget.category.name}",
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 10,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          "${widget.category.name} Recipes",
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const Text(
                          "142 comforting poultry dishes from savory stews to crispy...",
                          style: TextStyle(color: Colors.white70, fontSize: 10),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                children: [
                  _buildFilterChip("All(142)", true),
                  const SizedBox(width: 8),
                  _buildFilterChip("Under 30m", false),
                  const SizedBox(width: 8),
                  _buildFilterChip("Curries", false),
                  const SizedBox(width: 8),
                  _buildFilterChip("Grilled", false),
                  const SizedBox(width: 8),
                  _buildFilterChip("Soups", false),
                ],
              ),
            ),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 12),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Showing 6 recommended",
                    style: TextStyle(color: Colors.grey, fontSize: 12),
                  ),
                  Text(
                    "Sort: Popular \u{2193}",
                    style: TextStyle(
                      color: Color(0xFFD94A38),
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: _isLoading
                  ? const Center(child: CircularProgressIndicator())
                  : GridView.builder(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            childAspectRatio: 0.75,
                            crossAxisSpacing: 12,
                            mainAxisSpacing: 12,
                          ),
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
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: ElevatedButton.icon(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF4A4545),
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(24),
                  ),
                  padding: const EdgeInsets.symmetric(
                    vertical: 12,
                    horizontal: 24,
                  ),
                ),
                onPressed: () {
                  Navigator.pop(context);
                  if (widget.onNavigateToCategories != null) {
                    widget.onNavigateToCategories!();
                  }
                },
                icon: const Icon(Icons.grid_view, size: 16),
                label: const Text("All Categories"),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFilterChip(String label, bool isSelected) {
    bool active =
        _selectedFilter == label || (isSelected && _selectedFilter == "All");
    return GestureDetector(
      onTap: () => setState(() => _selectedFilter = label),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
        decoration: BoxDecoration(
          color: active
              ? const Color(0xFFD94A38)
              : Colors.grey.withValues(alpha: 0.1),
          borderRadius: BorderRadius.circular(20),
        ),
        child: Text(
          label,
          style: TextStyle(
            color: active ? Colors.white : Colors.black87,
            fontSize: 12,
            fontWeight: active ? FontWeight.bold : FontWeight.normal,
          ),
        ),
      ),
    );
  }
}
