class Recipe {
  final String id;
  final String title;
  final String imageUrl;
  final String time;
  final double rating;
  final String calories;
  final String category;
  bool isLiked;
  final List<String> ingredients;
  final List<String> steps;
  final String youtubeUrl;

  Recipe({
    required this.id,
    required this.title,
    required this.imageUrl,
    required this.time,
    required this.rating,
    required this.calories,
    required this.category,
    this.isLiked = false,
    required this.ingredients,
    required this.steps,
    this.youtubeUrl = '',
  });
}

class Category {
  final String name;
  final String imageUrl;
  final String recipeCount;

  Category({
    required this.name,
    required this.imageUrl,
    required this.recipeCount,
  });
}

// Global lists for simple state management
List<Recipe> globalLikedRecipes = [];

//Category api model
class CategoryResponse {
  List<Categories>? categories;

  CategoryResponse({this.categories});

  CategoryResponse.fromJson(Map<String, dynamic> json) {
    if (json['categories'] != null) {
      categories = <Categories>[];
      json['categories'].forEach((v) {
        categories!.add(Categories.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (categories != null) {
      data['categories'] = categories!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Categories {
  String? idCategory;
  String? strCategory;
  String? strCategoryThumb;
  String? strCategoryDescription;

  Categories({
    this.idCategory,
    this.strCategory,
    this.strCategoryThumb,
    this.strCategoryDescription,
  });

  Categories.fromJson(Map<String, dynamic> json) {
    idCategory = json['idCategory'];
    strCategory = json['strCategory'];
    strCategoryThumb = json['strCategoryThumb'];
    strCategoryDescription = json['strCategoryDescription'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['idCategory'] = idCategory;
    data['strCategory'] = strCategory;
    data['strCategoryThumb'] = strCategoryThumb;
    data['strCategoryDescription'] = strCategoryDescription;
    return data;
  }
}

// Search by name api

class SearchResponse {
  List<Meals>? meals;

  SearchResponse({this.meals});

  SearchResponse.fromJson(Map<String, dynamic> json) {
    if (json['meals'] != null) {
      meals = <Meals>[];
      json['meals'].forEach((v) {
        meals!.add(Meals.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (meals != null) {
      data['meals'] = meals!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Meals {
  String? idMeal;
  String? strMeal;
  Null strMealAlternate;
  String? strCategory;
  String? strArea;
  String? strCountry;
  String? strInstructions;
  String? strMealThumb;
  String? strTags;
  String? strYoutube;
  String? strIngredient1;
  String? strIngredient2;
  String? strIngredient3;
  String? strIngredient4;
  String? strIngredient5;
  String? strIngredient6;
  String? strIngredient7;
  String? strIngredient8;
  String? strIngredient9;
  String? strIngredient10;
  String? strIngredient11;
  String? strIngredient12;
  String? strIngredient13;
  String? strIngredient14;
  String? strIngredient15;
  Null strIngredient16;
  Null strIngredient17;
  Null strIngredient18;
  Null strIngredient19;
  Null strIngredient20;
  String? strMeasure1;
  String? strMeasure2;
  String? strMeasure3;
  String? strMeasure4;
  String? strMeasure5;
  String? strMeasure6;
  String? strMeasure7;
  String? strMeasure8;
  String? strMeasure9;
  String? strMeasure10;
  String? strMeasure11;
  String? strMeasure12;
  String? strMeasure13;
  String? strMeasure14;
  String? strMeasure15;
  Null strMeasure16;
  Null strMeasure17;
  Null strMeasure18;
  Null strMeasure19;
  Null strMeasure20;
  Null strSource;
  Null strImageSource;
  Null strCreativeCommonsConfirmed;
  Null dateModified;

  Meals({
    this.idMeal,
    this.strMeal,
    this.strMealAlternate,
    this.strCategory,
    this.strArea,
    this.strCountry,
    this.strInstructions,
    this.strMealThumb,
    this.strTags,
    this.strYoutube,
    this.strIngredient1,
    this.strIngredient2,
    this.strIngredient3,
    this.strIngredient4,
    this.strIngredient5,
    this.strIngredient6,
    this.strIngredient7,
    this.strIngredient8,
    this.strIngredient9,
    this.strIngredient10,
    this.strIngredient11,
    this.strIngredient12,
    this.strIngredient13,
    this.strIngredient14,
    this.strIngredient15,
    this.strIngredient16,
    this.strIngredient17,
    this.strIngredient18,
    this.strIngredient19,
    this.strIngredient20,
    this.strMeasure1,
    this.strMeasure2,
    this.strMeasure3,
    this.strMeasure4,
    this.strMeasure5,
    this.strMeasure6,
    this.strMeasure7,
    this.strMeasure8,
    this.strMeasure9,
    this.strMeasure10,
    this.strMeasure11,
    this.strMeasure12,
    this.strMeasure13,
    this.strMeasure14,
    this.strMeasure15,
    this.strMeasure16,
    this.strMeasure17,
    this.strMeasure18,
    this.strMeasure19,
    this.strMeasure20,
    this.strSource,
    this.strImageSource,
    this.strCreativeCommonsConfirmed,
    this.dateModified,
  });

  Meals.fromJson(Map<String, dynamic> json) {
    idMeal = json['idMeal'];
    strMeal = json['strMeal'];
    strMealAlternate = json['strMealAlternate'];
    strCategory = json['strCategory'];
    strArea = json['strArea'];
    strCountry = json['strCountry'];
    strInstructions = json['strInstructions'];
    strMealThumb = json['strMealThumb'];
    strTags = json['strTags'];
    strYoutube = json['strYoutube'];
    strIngredient1 = json['strIngredient1'];
    strIngredient2 = json['strIngredient2'];
    strIngredient3 = json['strIngredient3'];
    strIngredient4 = json['strIngredient4'];
    strIngredient5 = json['strIngredient5'];
    strIngredient6 = json['strIngredient6'];
    strIngredient7 = json['strIngredient7'];
    strIngredient8 = json['strIngredient8'];
    strIngredient9 = json['strIngredient9'];
    strIngredient10 = json['strIngredient10'];
    strIngredient11 = json['strIngredient11'];
    strIngredient12 = json['strIngredient12'];
    strIngredient13 = json['strIngredient13'];
    strIngredient14 = json['strIngredient14'];
    strIngredient15 = json['strIngredient15'];
    strIngredient16 = json['strIngredient16'];
    strIngredient17 = json['strIngredient17'];
    strIngredient18 = json['strIngredient18'];
    strIngredient19 = json['strIngredient19'];
    strIngredient20 = json['strIngredient20'];
    strMeasure1 = json['strMeasure1'];
    strMeasure2 = json['strMeasure2'];
    strMeasure3 = json['strMeasure3'];
    strMeasure4 = json['strMeasure4'];
    strMeasure5 = json['strMeasure5'];
    strMeasure6 = json['strMeasure6'];
    strMeasure7 = json['strMeasure7'];
    strMeasure8 = json['strMeasure8'];
    strMeasure9 = json['strMeasure9'];
    strMeasure10 = json['strMeasure10'];
    strMeasure11 = json['strMeasure11'];
    strMeasure12 = json['strMeasure12'];
    strMeasure13 = json['strMeasure13'];
    strMeasure14 = json['strMeasure14'];
    strMeasure15 = json['strMeasure15'];
    strMeasure16 = json['strMeasure16'];
    strMeasure17 = json['strMeasure17'];
    strMeasure18 = json['strMeasure18'];
    strMeasure19 = json['strMeasure19'];
    strMeasure20 = json['strMeasure20'];
    strSource = json['strSource'];
    strImageSource = json['strImageSource'];
    strCreativeCommonsConfirmed = json['strCreativeCommonsConfirmed'];
    dateModified = json['dateModified'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['idMeal'] = idMeal;
    data['strMeal'] = strMeal;
    data['strMealAlternate'] = strMealAlternate;
    data['strCategory'] = strCategory;
    data['strArea'] = strArea;
    data['strCountry'] = strCountry;
    data['strInstructions'] = strInstructions;
    data['strMealThumb'] = strMealThumb;
    data['strTags'] = strTags;
    data['strYoutube'] = strYoutube;
    data['strIngredient1'] = strIngredient1;
    data['strIngredient2'] = strIngredient2;
    data['strIngredient3'] = strIngredient3;
    data['strIngredient4'] = strIngredient4;
    data['strIngredient5'] = strIngredient5;
    data['strIngredient6'] = strIngredient6;
    data['strIngredient7'] = strIngredient7;
    data['strIngredient8'] = strIngredient8;
    data['strIngredient9'] = strIngredient9;
    data['strIngredient10'] = strIngredient10;
    data['strIngredient11'] = strIngredient11;
    data['strIngredient12'] = strIngredient12;
    data['strIngredient13'] = strIngredient13;
    data['strIngredient14'] = strIngredient14;
    data['strIngredient15'] = strIngredient15;
    data['strIngredient16'] = strIngredient16;
    data['strIngredient17'] = strIngredient17;
    data['strIngredient18'] = strIngredient18;
    data['strIngredient19'] = strIngredient19;
    data['strIngredient20'] = strIngredient20;
    data['strMeasure1'] = strMeasure1;
    data['strMeasure2'] = strMeasure2;
    data['strMeasure3'] = strMeasure3;
    data['strMeasure4'] = strMeasure4;
    data['strMeasure5'] = strMeasure5;
    data['strMeasure6'] = strMeasure6;
    data['strMeasure7'] = strMeasure7;
    data['strMeasure8'] = strMeasure8;
    data['strMeasure9'] = strMeasure9;
    data['strMeasure10'] = strMeasure10;
    data['strMeasure11'] = strMeasure11;
    data['strMeasure12'] = strMeasure12;
    data['strMeasure13'] = strMeasure13;
    data['strMeasure14'] = strMeasure14;
    data['strMeasure15'] = strMeasure15;
    data['strMeasure16'] = strMeasure16;
    data['strMeasure17'] = strMeasure17;
    data['strMeasure18'] = strMeasure18;
    data['strMeasure19'] = strMeasure19;
    data['strMeasure20'] = strMeasure20;
    data['strSource'] = strSource;
    data['strImageSource'] = strImageSource;
    data['strCreativeCommonsConfirmed'] = strCreativeCommonsConfirmed;
    data['dateModified'] = dateModified;
    return data;
  }
}

// Recipe details page api

class RecipeResponse {
  List<Meal>? meals;

  RecipeResponse({this.meals});

  RecipeResponse.fromJson(Map<String, dynamic> json) {
    if (json['meals'] != null) {
      meals = <Meal>[];
      json['meals'].forEach((v) {
        meals!.add(Meal.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (meals != null) {
      data['meals'] = meals!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Meal {
  String? idMeal;
  String? strMeal;
  String? strMealAlternate;
  String? strCategory;
  String? strArea;
  String? strCountry;
  String? strInstructions;
  String? strMealThumb;
  String? strTags;
  String? strYoutube;
  String? strIngredient1;
  String? strIngredient2;
  String? strIngredient3;
  String? strIngredient4;
  String? strIngredient5;
  String? strIngredient6;
  String? strIngredient7;
  String? strIngredient8;
  String? strIngredient9;
  String? strIngredient10;
  String? strIngredient11;
  String? strIngredient12;
  String? strIngredient13;
  String? strIngredient14;
  String? strIngredient15;
  String? strIngredient16;
  String? strIngredient17;
  String? strIngredient18;
  String? strIngredient19;
  String? strIngredient20;
  String? strMeasure1;
  String? strMeasure2;
  String? strMeasure3;
  String? strMeasure4;
  String? strMeasure5;
  String? strMeasure6;
  String? strMeasure7;
  String? strMeasure8;
  String? strMeasure9;
  String? strMeasure10;
  String? strMeasure11;
  String? strMeasure12;
  String? strMeasure13;
  String? strMeasure14;
  String? strMeasure15;
  String? strMeasure16;
  String? strMeasure17;
  String? strMeasure18;
  String? strMeasure19;
  String? strMeasure20;
  String? strSource;
  String? strImageSource;
  String? strCreativeCommonsConfirmed;
  String? dateModified;

  Meal({
    this.idMeal,
    this.strMeal,
    this.strMealAlternate,
    this.strCategory,
    this.strArea,
    this.strCountry,
    this.strInstructions,
    this.strMealThumb,
    this.strTags,
    this.strYoutube,
    this.strIngredient1,
    this.strIngredient2,
    this.strIngredient3,
    this.strIngredient4,
    this.strIngredient5,
    this.strIngredient6,
    this.strIngredient7,
    this.strIngredient8,
    this.strIngredient9,
    this.strIngredient10,
    this.strIngredient11,
    this.strIngredient12,
    this.strIngredient13,
    this.strIngredient14,
    this.strIngredient15,
    this.strIngredient16,
    this.strIngredient17,
    this.strIngredient18,
    this.strIngredient19,
    this.strIngredient20,
    this.strMeasure1,
    this.strMeasure2,
    this.strMeasure3,
    this.strMeasure4,
    this.strMeasure5,
    this.strMeasure6,
    this.strMeasure7,
    this.strMeasure8,
    this.strMeasure9,
    this.strMeasure10,
    this.strMeasure11,
    this.strMeasure12,
    this.strMeasure13,
    this.strMeasure14,
    this.strMeasure15,
    this.strMeasure16,
    this.strMeasure17,
    this.strMeasure18,
    this.strMeasure19,
    this.strMeasure20,
    this.strSource,
    this.strImageSource,
    this.strCreativeCommonsConfirmed,
    this.dateModified,
  });

  Meal.fromJson(Map<String, dynamic> json) {
    idMeal = json['idMeal']?.toString();
    strMeal = json['strMeal']?.toString();
    strMealAlternate = json['strMealAlternate']?.toString();
    strCategory = json['strCategory']?.toString();
    strArea = json['strArea']?.toString();
    strCountry = json['strCountry']?.toString();
    strInstructions = json['strInstructions']?.toString();
    strMealThumb = json['strMealThumb']?.toString();
    strTags = json['strTags']?.toString();
    strYoutube = json['strYoutube']?.toString();
    strIngredient1 = json['strIngredient1']?.toString();
    strIngredient2 = json['strIngredient2']?.toString();
    strIngredient3 = json['strIngredient3']?.toString();
    strIngredient4 = json['strIngredient4']?.toString();
    strIngredient5 = json['strIngredient5']?.toString();
    strIngredient6 = json['strIngredient6']?.toString();
    strIngredient7 = json['strIngredient7']?.toString();
    strIngredient8 = json['strIngredient8']?.toString();
    strIngredient9 = json['strIngredient9']?.toString();
    strIngredient10 = json['strIngredient10']?.toString();
    strIngredient11 = json['strIngredient11']?.toString();
    strIngredient12 = json['strIngredient12']?.toString();
    strIngredient13 = json['strIngredient13']?.toString();
    strIngredient14 = json['strIngredient14']?.toString();
    strIngredient15 = json['strIngredient15']?.toString();
    strIngredient16 = json['strIngredient16']?.toString();
    strIngredient17 = json['strIngredient17']?.toString();
    strIngredient18 = json['strIngredient18']?.toString();
    strIngredient19 = json['strIngredient19']?.toString();
    strIngredient20 = json['strIngredient20']?.toString();
    strMeasure1 = json['strMeasure1']?.toString();
    strMeasure2 = json['strMeasure2']?.toString();
    strMeasure3 = json['strMeasure3']?.toString();
    strMeasure4 = json['strMeasure4']?.toString();
    strMeasure5 = json['strMeasure5']?.toString();
    strMeasure6 = json['strMeasure6']?.toString();
    strMeasure7 = json['strMeasure7']?.toString();
    strMeasure8 = json['strMeasure8']?.toString();
    strMeasure9 = json['strMeasure9']?.toString();
    strMeasure10 = json['strMeasure10']?.toString();
    strMeasure11 = json['strMeasure11']?.toString();
    strMeasure12 = json['strMeasure12']?.toString();
    strMeasure13 = json['strMeasure13']?.toString();
    strMeasure14 = json['strMeasure14']?.toString();
    strMeasure15 = json['strMeasure15']?.toString();
    strMeasure16 = json['strMeasure16']?.toString();
    strMeasure17 = json['strMeasure17']?.toString();
    strMeasure18 = json['strMeasure18']?.toString();
    strMeasure19 = json['strMeasure19']?.toString();
    strMeasure20 = json['strMeasure20']?.toString();
    strSource = json['strSource']?.toString();
    strImageSource = json['strImageSource']?.toString();
    strCreativeCommonsConfirmed = json['strCreativeCommonsConfirmed']
        ?.toString();
    dateModified = json['dateModified']?.toString();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['idMeal'] = idMeal;
    data['strMeal'] = strMeal;
    data['strMealAlternate'] = strMealAlternate;
    data['strCategory'] = strCategory;
    data['strArea'] = strArea;
    data['strCountry'] = strCountry;
    data['strInstructions'] = strInstructions;
    data['strMealThumb'] = strMealThumb;
    data['strTags'] = strTags;
    data['strYoutube'] = strYoutube;
    data['strIngredient1'] = strIngredient1;
    data['strIngredient2'] = strIngredient2;
    data['strIngredient3'] = strIngredient3;
    data['strIngredient4'] = strIngredient4;
    data['strIngredient5'] = strIngredient5;
    data['strIngredient6'] = strIngredient6;
    data['strIngredient7'] = strIngredient7;
    data['strIngredient8'] = strIngredient8;
    data['strIngredient9'] = strIngredient9;
    data['strIngredient10'] = strIngredient10;
    data['strIngredient11'] = strIngredient11;
    data['strIngredient12'] = strIngredient12;
    data['strIngredient13'] = strIngredient13;
    data['strIngredient14'] = strIngredient14;
    data['strIngredient15'] = strIngredient15;
    data['strIngredient16'] = strIngredient16;
    data['strIngredient17'] = strIngredient17;
    data['strIngredient18'] = strIngredient18;
    data['strIngredient19'] = strIngredient19;
    data['strIngredient20'] = strIngredient20;
    data['strMeasure1'] = strMeasure1;
    data['strMeasure2'] = strMeasure2;
    data['strMeasure3'] = strMeasure3;
    data['strMeasure4'] = strMeasure4;
    data['strMeasure5'] = strMeasure5;
    data['strMeasure6'] = strMeasure6;
    data['strMeasure7'] = strMeasure7;
    data['strMeasure8'] = strMeasure8;
    data['strMeasure9'] = strMeasure9;
    data['strMeasure10'] = strMeasure10;
    data['strMeasure11'] = strMeasure11;
    data['strMeasure12'] = strMeasure12;
    data['strMeasure13'] = strMeasure13;
    data['strMeasure14'] = strMeasure14;
    data['strMeasure15'] = strMeasure15;
    data['strMeasure16'] = strMeasure16;
    data['strMeasure17'] = strMeasure17;
    data['strMeasure18'] = strMeasure18;
    data['strMeasure19'] = strMeasure19;
    data['strMeasure20'] = strMeasure20;
    data['strSource'] = strSource;
    data['strImageSource'] = strImageSource;
    data['strCreativeCommonsConfirmed'] = strCreativeCommonsConfirmed;
    data['dateModified'] = dateModified;
    return data;
  }
}

class FilterResponse {
  List<SimpleRecipe>? meals;

  FilterResponse({this.meals});

  FilterResponse.fromJson(Map<String, dynamic> json) {
    if (json['meals'] != null) {
      meals = <SimpleRecipe>[];
      json['meals'].forEach((v) {
        meals!.add(SimpleRecipe.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (meals != null) {
      data['meals'] = meals!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class SimpleRecipe {
  String? strMeal;
  String? strMealThumb;
  String? idMeal;

  SimpleRecipe({this.strMeal, this.strMealThumb, this.idMeal});

  SimpleRecipe.fromJson(Map<String, dynamic> json) {
    strMeal = json['strMeal']?.toString();
    strMealThumb = json['strMealThumb']?.toString();
    idMeal = json['idMeal']?.toString();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['strMeal'] = strMeal;
    data['strMealThumb'] = strMealThumb;
    data['idMeal'] = idMeal;
    return data;
  }
}
