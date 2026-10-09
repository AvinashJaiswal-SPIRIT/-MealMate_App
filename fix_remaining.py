import re
with open('lib/category_results.dart', 'r', encoding='utf-8') as f:
    c = f.read()

c = c.replace('child: ListView.builder(', 'child: _isLoading ? const Center(child: CircularProgressIndicator()) : ListView.builder(')

with open('lib/category_results.dart', 'w', encoding='utf-8') as f:
    f.write(c)

with open('lib/search_tab.dart', 'r', encoding='utf-8') as f:
    c2 = f.read()

search_fn = """
  void _performSearch(String value) async {
    if (value.isEmpty) {
      if (mounted) setState(() { _recipes = []; });
      return;
    }
    if (mounted) setState(() { _isLoading = true; _searchQuery = value; });
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

c2 = c2.replace('String _searchQuery = "";', search_fn + '  String _searchQuery = "";')
c2 = re.sub(r'onSubmitted:\s*\(value\)\s*\{[\s\S]*?\},', 'onSubmitted: _performSearch,', c2)
c2 = c2.replace('child: ListView.builder(', 'child: _isLoading ? const Center(child: CircularProgressIndicator()) : ListView.builder(')

with open('lib/search_tab.dart', 'w', encoding='utf-8') as f:
    f.write(c2)
