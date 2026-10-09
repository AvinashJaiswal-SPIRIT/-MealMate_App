import 'package:flutter/material.dart';

import 'models.dart';
import 'widgets.dart';
import 'recipe_detail.dart';

class LikedTab extends StatefulWidget {
  const LikedTab({super.key});

  @override
  State<LikedTab> createState() => _LikedTabState();
}

class _LikedTabState extends State<LikedTab> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFAF9F6),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const MealMateHeader(),

            if (globalLikedRecipes.isEmpty)
              const Expanded(
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.favorite_border,
                        size: 60,
                        color: Colors.grey,
                      ),
                      SizedBox(height: 16),
                      Text(
                        "No liked recipes yet!",
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.grey,
                        ),
                      ),
                    ],
                  ),
                ),
              )
            else
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              const Text(
                                "Liked Meals",
                                style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 22,
                                ),
                              ),
                              const SizedBox(width: 8),

                              Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 6,
                                  vertical: 2,
                                ),
                                decoration: BoxDecoration(
                                  color: const Color(0xFFD94A38)
                                      .withValues(alpha: 0.1),
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: Text(
                                  "${globalLikedRecipes.length}",
                                  style: const TextStyle(
                                    color: Color(0xFFD94A38),
                                    fontSize: 12,
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
                              color: Colors.grey.withValues(alpha: 0.1),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Row(
                              children: const [
                                Icon(
                                  Icons.auto_graph,
                                  size: 14,
                                  color: Color(0xFFD94A38),
                                ),
                                SizedBox(width: 4),
                                Text(
                                  "Test Empty",
                                  style: TextStyle(
                                    color: Colors.grey,
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

                    // Describes how many recipes have been saved.
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16.0,
                        vertical: 4.0,
                      ),
                      child: Text(
                        "${globalLikedRecipes.length} saved recipes ready to cook",
                        style: const TextStyle(
                          color: Colors.grey,
                          fontSize: 12,
                        ),
                      ),
                    ),

                    const SizedBox(height: 16),

                    // Sorting and cooking-time display controls.
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      child: Row(
                        children: [
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 12,
                              vertical: 6,
                            ),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(20),
                              border: Border.all(
                                color: Colors.grey.withValues(alpha: 0.2),
                              ),
                            ),
                            child: Row(
                              children: const [
                                Icon(
                                  Icons.sort,
                                  size: 14,
                                  color: Colors.black87,
                                ),
                                SizedBox(width: 4),
                                Text(
                                  "Recently Added",
                                  style: TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Icon(Icons.arrow_drop_down, size: 16),
                              ],
                            ),
                          ),

                          const SizedBox(width: 8),

                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 12,
                              vertical: 6,
                            ),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(20),
                              border: Border.all(
                                color: Colors.grey.withValues(alpha: 0.2),
                              ),
                            ),
                            child: Row(
                              children: const [
                                Icon(
                                  Icons.check_circle_outline,
                                  size: 14,
                                  color: Colors.green,
                                ),
                                SizedBox(width: 4),
                                Text(
                                  "Cook of time",
                                  style: TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                          ),

                          const Spacer(),

                          GestureDetector(
                            onTap: () {
                              setState(() {

                                for (var r in globalLikedRecipes) {
                                  r.isLiked = false;
                                }
                                globalLikedRecipes.clear();
                              });
                            },
                            child: const Text(
                              "Clear all",
                              style: TextStyle(
                                color: Color(0xFFD94A38),
                                fontSize: 12,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 16),

                    // Builds a scrollable list of saved recipes.
                    Expanded(
                      child: ListView.builder(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        itemCount: globalLikedRecipes.length,
                        itemBuilder: (context, index) {
                          return LikedRecipeCard(
                            recipe: globalLikedRecipes[index],

                            onUnlike: () {
                              setState(() {
                                globalLikedRecipes[index].isLiked = false;
                                globalLikedRecipes.removeAt(index);
                              });
                            },

                            // Opens the selected recipe's detail page.
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => RecipeDetail(
                                    recipe: globalLikedRecipes[index],
                                  ),
                                ),
                              ).then((_) {
                                setState(() {});
                              });
                            },
                          );
                        },
                      ),
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