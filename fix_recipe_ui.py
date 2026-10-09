import re
with open('lib/recipe_detail.dart', 'r', encoding='utf-8') as f:
    c = f.read()

# Fix ingredients
ing_regex = r'\.\.\._recipe\.ingredients\.asMap\(\)\.entries\.map\(\(entry\) \{[\s\S]*?\}\),'
ing_replacement = '''..._recipe.ingredients.asMap().entries.map((entry) {
                      int idx = entry.key;
                      String ing = entry.value;
                      bool isChecked = idx < _checkedIngredients.length ? _checkedIngredients[idx] : false;

                      return IngredientRow(
                        ingredient: ing,
                        amount: "", // Amount is included in the string already
                        isChecked: isChecked,
                        onTap: () => setState(() {
                          if (idx < _checkedIngredients.length) {
                            _checkedIngredients[idx] = !isChecked;
                          }
                        }),
                      );
                    }),'''

c = re.sub(ing_regex, ing_replacement, c)

# Fix steps
steps_regex = r'Row\([\s\S]*?const StepCard\([\s\S]*?const StepCard\([\s\S]*?const StepCard\([\s\S]*?\),'
steps_replacement = '''Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          "Step-by-Step Instructions",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          "${_recipe.steps.length} Steps",
                          style: const TextStyle(color: Colors.grey, fontSize: 12),
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),
                    ..._recipe.steps.asMap().entries.map((entry) {
                      return StepCard(
                        num: entry.key + 1,
                        title: "Step ${entry.key + 1}",
                        desc: entry.value,
                      );
                    }),'''

c = re.sub(steps_regex, steps_replacement, c)

# Fix Youtube video button
yt_regex = r'Container\([\s\S]*?child: const Center\([\s\S]*?child: CircleAvatar\([\s\S]*?child: Icon\([\s\S]*?Icons\.play_arrow,[\s\S]*?size: 28,[\s\S]*?\),[\s\S]*?\),[\s\S]*?\),[\s\S]*?\),'
yt_replacement = '''GestureDetector(
                      onTap: () async {
                        if (_recipe.youtubeUrl.isNotEmpty) {
                          final uri = Uri.parse(_recipe.youtubeUrl);
                          if (await canLaunchUrl(uri)) {
                            await launchUrl(uri);
                          } else {
                            if (mounted) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(content: Text('Could not open video.')),
                              );
                            }
                          }
                        }
                      },
                      child: Container(
                        height: 150,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          image: DecorationImage(
                            image: NetworkImage(
                              _recipe.imageUrl.isNotEmpty ? _recipe.imageUrl : 'https://images.unsplash.com/photo-1556910103-1c02745aae4d?auto=format&fit=crop&w=600',
                            ),
                            fit: BoxFit.cover,
                            colorFilter: ColorFilter.mode(
                              Colors.black.withOpacity(0.3),
                              BlendMode.darken,
                            ),
                          ),
                        ),
                        child: Center(
                          child: CircleAvatar(
                            backgroundColor: _recipe.youtubeUrl.isNotEmpty ? const Color(0xFFD94A38) : Colors.grey,
                            radius: 24,
                            child: const Icon(
                              Icons.play_arrow,
                              color: Colors.white,
                              size: 28,
                            ),
                          ),
                        ),
                      ),
                    ),'''

c = re.sub(yt_regex, yt_replacement, c)

with open('lib/recipe_detail.dart', 'w', encoding='utf-8') as f:
    f.write(c)
