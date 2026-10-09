import re

# 1. Fix api_service.dart
with open('lib/api_service.dart', 'r', encoding='utf-8') as f:
    c1 = f.read()

# Currently: ingredients.add("${meas ?? ''} $ing".trim());
# Change to: ingredients.add("${ing.trim()}|||${(meas ?? '').trim()}");
c1 = c1.replace('ingredients.add("${meas ?? \'\'} $ing".trim());', 'ingredients.add("${ing.trim()}|||${(meas ?? \'\').trim()}");')
with open('lib/api_service.dart', 'w', encoding='utf-8') as f:
    f.write(c1)

# 2. Fix recipe_detail.dart
with open('lib/recipe_detail.dart', 'r', encoding='utf-8') as f:
    c2 = f.read()

ing_regex = r'''String ing = entry\.value;[\s\S]*?bool isChecked = idx < _checkedIngredients\.length \? _checkedIngredients\[idx\] : false;[\s\S]*?return IngredientRow\([\s\S]*?ingredient: ing,[\s\S]*?amount: "",\s*// Amount is included in the string already[\s\S]*?isChecked: isChecked,'''

ing_replacement = '''String raw = entry.value;
                      String ing = raw;
                      String amt = "";
                      if (raw.contains("|||")) {
                        final parts = raw.split("|||");
                        ing = parts[0];
                        amt = parts[1];
                      }
                      bool isChecked = idx < _checkedIngredients.length ? _checkedIngredients[idx] : false;

                      return IngredientRow(
                        ingredient: ing,
                        amount: amt,
                        isChecked: isChecked,'''

c2 = re.sub(ing_regex, ing_replacement, c2)
with open('lib/recipe_detail.dart', 'w', encoding='utf-8') as f:
    f.write(c2)


# 3. Fix home_tab.dart
with open('lib/home_tab.dart', 'r', encoding='utf-8') as f:
    c3 = f.read()

# Find the Surprise Me button logic
surprise_regex = r'''onPressed: \(\) \{[\s\S]*?final randomRecipe =[\s\S]*?_recipes\[Random\(\)\.nextInt\([\s\S]*?_recipes\.length,[\s\S]*?\)\];[\s\S]*?Navigator\.push\([\s\S]*?context,[\s\S]*?MaterialPageRoute\([\s\S]*?builder: \(context\) =>[\s\S]*?RecipeDetail\(recipe: randomRecipe\),[\s\S]*?\),[\s\S]*?\);[\s\S]*?\},'''

surprise_replacement = '''onPressed: () async {
                                  // Show a tiny snackbar to indicate loading
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(content: Text("Finding a surprise meal..."), duration: Duration(milliseconds: 500)),
                                  );
                                  
                                  final randomRecipe = await ApiService.getRandomMeal();
                                  if (randomRecipe != null && mounted) {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            RecipeDetail(recipe: randomRecipe),
                                      ),
                                    );
                                  }
                                },'''

c3 = re.sub(surprise_regex, surprise_replacement, c3)
with open('lib/home_tab.dart', 'w', encoding='utf-8') as f:
    f.write(c3)
