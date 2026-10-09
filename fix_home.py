import re

with open("lib/home_tab.dart", "r", encoding="utf-8") as f:
    content = f.read()

if "import 'api_service.dart';" not in content:
    content = content.replace("import 'widgets.dart';", "import 'widgets.dart';\nimport 'api_service.dart';")

init_state = """
  List<Recipe> _recipes = [];
  List<Category> _categories = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadData();
  }

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
      if (mounted) setState(() { _isLoading = false; });
    }
  }
"""

content = content.replace("class _HomeTabState extends State<HomeTab> {", "class _HomeTabState extends State<HomeTab> {" + init_state)
content = content.replace("dummyRecipes", "_recipes")
content = content.replace("dummyCategories", "_categories")
content = content.replace("child: SingleChildScrollView(", "child: _isLoading ? const Center(child: CircularProgressIndicator()) : SingleChildScrollView(")

with open("lib/home_tab.dart", "w", encoding="utf-8") as f:
    f.write(content)

with open("lib/categories_tab.dart", "r", encoding="utf-8") as f:
    content2 = f.read()

if "import 'api_service.dart';" not in content2:
    content2 = content2.replace("import 'widgets.dart';", "import 'widgets.dart';\nimport 'api_service.dart';")

init_state2 = """
  List<Category> _categories = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadData();
  }

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
      if (mounted) setState(() { _isLoading = false; });
    }
  }
"""

content2 = content2.replace("class _CategoriesTabState extends State<CategoriesTab> {", "class _CategoriesTabState extends State<CategoriesTab> {" + init_state2)
content2 = content2.replace("dummyCategories", "_categories")
content2 = content2.replace("child: GridView.builder(", "child: _isLoading ? const Center(child: CircularProgressIndicator()) : GridView.builder(")

with open("lib/categories_tab.dart", "w", encoding="utf-8") as f:
    f.write(content2)

with open("lib/category_results.dart", "r", encoding="utf-8") as f:
    content3 = f.read()

if "import 'api_service.dart';" not in content3:
    content3 = content3.replace("import 'widgets.dart';", "import 'widgets.dart';\nimport 'api_service.dart';")

init_state3 = """
  List<Recipe> _recipes = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  void _loadData() async {
    try {
      final res = await ApiService.getMealsByCategory(widget.category.name);
      if (mounted) {
        setState(() {
          _recipes = res;
          _isLoading = false;
        });
      }
    } catch (e) {
      if (mounted) setState(() { _isLoading = false; });
    }
  }
"""

content3 = content3.replace("class _CategoryResultsPageState extends State<CategoryResultsPage> {", "class _CategoryResultsPageState extends State<CategoryResultsPage> {" + init_state3)
content3 = content3.replace("dummyRecipes", "_recipes")
content3 = content3.replace("child: ListView.builder(", "child: _isLoading ? const Center(child: CircularProgressIndicator()) : ListView.builder(")

with open("lib/category_results.dart", "w", encoding="utf-8") as f:
    f.write(content3)

with open("lib/search_tab.dart", "r", encoding="utf-8") as f:
    content4 = f.read()

if "import 'api_service.dart';" not in content4:
    content4 = content4.replace("import 'widgets.dart';", "import 'widgets.dart';\nimport 'api_service.dart';")

init_state4 = """
  List<Recipe> _recipes = [];
  bool _isLoading = false;
"""

content4 = content4.replace("class _SearchTabState extends State<SearchTab> {", "class _SearchTabState extends State<SearchTab> {" + init_state4)
content4 = content4.replace("dummyRecipes", "_recipes")
content4 = content4.replace("child: ListView.builder(", "child: _isLoading ? const Center(child: CircularProgressIndicator()) : ListView.builder(")

search_fn = """
  void _performSearch(String value) async {
    if (value.isEmpty) {
      setState(() => _recipes = []);
      return;
    }
    setState(() => _isLoading = true);
    try {
      final res = await ApiService.searchMeals(value);
      if (mounted) {
        setState(() {
          _recipes = res;
          _isLoading = false;
        });
      }
    } catch (e) {
      if (mounted) setState(() => _isLoading = false);
    }
  }
"""
content4 = content4.replace("void dispose() {", search_fn + "\n  @override\n  void dispose() {")
content4 = re.sub(r'onSubmitted:\s*\(value\)\s*\{[\s\S]*?\},', 'onSubmitted: _performSearch,', content4)
content4 = re.sub(r'onPressed:\s*\(\)\s*\{\s*_controller\.clear\(\);\s*setState\(\(\)\s*\{\s*_searchQuery\s*=\s*"";\s*\}\);\s*\}', 'onPressed: () { _controller.clear(); setState(() { _searchQuery = ""; _recipes = []; }); }', content4)

with open("lib/search_tab.dart", "w", encoding="utf-8") as f:
    f.write(content4)
