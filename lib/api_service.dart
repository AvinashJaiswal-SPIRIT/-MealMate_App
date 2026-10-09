import 'dart:convert';
import 'package:http/http.dart' as http;
import 'models.dart';

class ApiService {
  // Base URL used for all TheMealDB API requests.
  static const String _baseUrl =
      'https://www.themealdb.com/api/json/v1/1';

  // Converts API category data into our Category model.
  static Category _toCategory(Categories cat) {
    return Category(
      name: cat.strCategory ?? '',
      imageUrl: cat.strCategoryThumb ?? '',
      recipeCount: "100 Recipes",
    );
  }

  // Converts complete API meal data into our Recipe model.
  static Recipe _toRecipeFromMeal(Meal meal) {
    List<String> ingredients = [];

    // Converts the Meal object into a Map to access ingredient fields.
    final map = meal.toJson();

    // Loops through all 20 possible ingredient and measurement fields.
    for (int i = 1; i <= 20; i++) {
      final ing = map['strIngredient$i'];
      final meas = map['strMeasure$i'];

      // Adds only ingredients that are not null or empty.
      if (ing != null && ing.toString().trim().isNotEmpty) {
        ingredients.add("${ing.trim()}|||${(meas ?? '').trim()}");
      }
    }

    // Stores the cooking instructions as separate steps.
    List<String> steps = [];

    // Checks whether cooking instructions are available.
    if (meal.strInstructions != null &&
        meal.strInstructions!.isNotEmpty) {
      steps = meal.strInstructions!
          .replaceAll('\r', '').split('\n').map((s) => s.trim()).where((s) {
        if (s.isEmpty) return false;

        final lower = s.toLowerCase();
        if (RegExp(r'^step\s*\d+$').hasMatch(lower)) return false;
        if (RegExp(r'^\d+[\.\)]?$').hasMatch(lower)) return false;
        return true;
      }).toList();
    }

    // Creates a Recipe object using the processed meal data.
    return Recipe(
      id: meal.idMeal ?? '',
      title: meal.strMeal ?? '',
      imageUrl: meal.strMealThumb ?? '',
      time: "25 mins",
      rating: 4.8,
      calories: "450 kcal",
      category: meal.strCategory ?? 'Unknown',
      ingredients: ingredients.isEmpty ? ["No ingredients"] : ingredients,
      steps: steps.isEmpty ? ["No instructions"] : steps,
      youtubeUrl: meal.strYoutube ?? '',
    );
  }

  // Converts basic API meal data into our Recipe model.
  static Recipe _toRecipeFromSimple(SimpleRecipe recipe) {
    return Recipe(
      id: recipe.idMeal ?? '',
      title: recipe.strMeal ?? '',
      imageUrl: recipe.strMealThumb ?? '',
      time: "25 mins",
      rating: 4.8,
      calories: "450 kcal",
      category: 'Unknown',
      ingredients: [],
      steps: [],
    );
  }

  // Fetches all available recipe categories.
  static Future<List<Category>> getCategories() async {
    final response = await http.get(
      Uri.parse('$_baseUrl/categories.php'),
    );
    if (response.statusCode == 200) {
      final decodedData = json.decode(response.body);

      final categoryResponse = CategoryResponse.fromJson(decodedData);

      return (categoryResponse.categories ?? []).map(_toCategory).toList();
    }

    throw Exception('Failed to load categories');
  }

  // Fetches meals belonging to the selected category.
  static Future<List<Recipe>> getMealsByCategory(String category) async {
    final response = await http.get(
      Uri.parse('$_baseUrl/filter.php?c=$category'),
    );
    if (response.statusCode == 200) {
      final decodedData = json.decode(response.body);

      final filterResponse = FilterResponse.fromJson(decodedData);

      return (filterResponse.meals ?? []).map(_toRecipeFromSimple).toList();
    }

    throw Exception('Failed to load meals for category: $category');
  }

  // Fetches complete details of a meal using its ID.
  static Future<Recipe?> getMealDetails(String id) async {
    final response = await http.get(
      Uri.parse('$_baseUrl/lookup.php?i=$id'),
    );
    if (response.statusCode == 200) {
      final decodedData = json.decode(response.body);
      final recipeResponse = RecipeResponse.fromJson(decodedData);

      if (recipeResponse.meals != null &&
          recipeResponse.meals!.isNotEmpty) {

        return _toRecipeFromMeal(recipeResponse.meals!.first);
      }
      return null;
    }

    throw Exception('Failed to load meal details');
  }

  // Searches for meals by name.
  static Future<List<Recipe>> searchMeals(String query) async {
    final response = await http.get(
      Uri.parse('$_baseUrl/search.php?s=$query'),
    );

    if (response.statusCode == 200) {
      final decodedData = json.decode(response.body);

      if (decodedData['meals'] == null) {
        return [];
      }

      final recipeResponse = RecipeResponse.fromJson(decodedData);

      return (recipeResponse.meals ?? []).map(_toRecipeFromMeal).toList();
    }

    throw Exception('Failed to search meals');
  }

  // Fetches one random meal from TheMealDB.
  static Future<Recipe?> getRandomMeal() async {
    final response = await http.get(
      Uri.parse('$_baseUrl/random.php'),
    );

    if (response.statusCode == 200) {
      final decodedData = json.decode(response.body);
      final recipeResponse = RecipeResponse.fromJson(decodedData);

      if (recipeResponse.meals != null &&
          recipeResponse.meals!.isNotEmpty) {
        // Converts the first meal into our Recipe model.
        return _toRecipeFromMeal(recipeResponse.meals!.first);
      }

      return null;
    }
    throw Exception('Failed to load random meal');
  }
}