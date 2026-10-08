import 'dart:convert';
import 'package:http/http.dart' as http;
import 'models.dart';

class ApiService {
  static const String _baseUrl = 'https://www.themealdb.com/api/json/v1/1';

  // Fetch all categories
  static Future<List<Categories>> getCategories() async {
    final response = await http.get(Uri.parse('$_baseUrl/categories.php'));

    if (response.statusCode == 200) {
      final decodedData = json.decode(response.body);
      final categoryResponse = CategoryResponse.fromJson(decodedData);
      return categoryResponse.categories ?? [];
    } else {
      throw Exception('Failed to load categories');
    }
  }

  // We will add more functions here for Random Meals, Search, and Category Results next!
}
