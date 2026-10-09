import re
with open('lib/recipe_detail.dart', 'r', encoding='utf-8') as f:
    c = f.read()

if "import 'api_service.dart';" not in c:
    c = c.replace("import 'recipe_widgets.dart';", "import 'recipe_widgets.dart';\nimport 'api_service.dart';\nimport 'package:url_launcher/url_launcher.dart';")

init_state = """
  int _servings = 4;
  late List<bool> _checkedIngredients;
  final String _maleAvatar = 'https://images.unsplash.com/photo-1633332755192-727a05c4013d?auto=format&fit=crop&w=150';
  late Recipe _recipe;
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _recipe = widget.recipe;
    _checkedIngredients = List<bool>.filled(
      _recipe.ingredients.length,
      false,
    );
    if (_recipe.ingredients.isEmpty) {
      _fetchFullRecipe();
    }
  }

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
      }
    } catch (e) {
      if (mounted) setState(() => _isLoading = false);
    }
  }
"""

c = re.sub(r'int _servings = 4;[\s\S]*?\}\n', init_state, c, count=1)
c = c.replace('widget.recipe', '_recipe')
# but wait! widget.recipe was replaced with _recipe, but in initState I just used widget.recipe which will become _recipe!
# so _recipe = widget.recipe becomes _recipe = _recipe! I need to fix that.
c = c.replace('_recipe = _recipe;', '_recipe = widget.recipe;')

c = c.replace('body: SafeArea(', 'body: _isLoading ? const Center(child: CircularProgressIndicator()) : SafeArea(')

with open('lib/recipe_detail.dart', 'w', encoding='utf-8') as f:
    f.write(c)
