import re
with open('lib/recipe_detail.dart', 'r', encoding='utf-8') as f:
    c = f.read()

# Fix ingredients
c = re.sub(r'String amt = \[[^\]]*\]\[idx % 8\];', 'String amt = "";', c)

# Fix steps
steps_regex = r'''const StepCard\([\s\S]*?num: 1,[\s\S]*?desc: "Chop all the vegetables and prepare the marinade for the main dish\.",\s*\),\s*const StepCard\([\s\S]*?num: 2,[\s\S]*?desc: "Heat oil in a pan, add the aromatics and cook until golden brown\.",\s*\),\s*const StepCard\([\s\S]*?num: 3,[\s\S]*?desc: "Add the main ingredients and let it simmer until cooked thoroughly\.",\s*\),'''

steps_replacement = '''..._recipe.steps.asMap().entries.map((entry) {
                      return StepCard(
                        num: entry.key + 1,
                        title: "Step ${entry.key + 1}",
                        desc: entry.value,
                      );
                    }),'''

c = re.sub(steps_regex, steps_replacement, c)

# Replace "4 Steps" hardcode with actual length
c = re.sub(r'"4 Steps"', '"${_recipe.steps.length} Steps"', c)

# Fix youtube video container
yt_regex = r'''Container\(\s*height: 150,\s*width: double\.infinity,\s*decoration: BoxDecoration\(\s*borderRadius: BorderRadius\.circular\(12\),\s*image: const DecorationImage\(\s*image: NetworkImage\(\s*'https://images\.unsplash\.com/photo-1556910103-1c02745aae4d\?auto=format&fit=crop&w=600',\s*\),\s*fit: BoxFit\.cover,\s*\),\s*\),\s*child: const Center\(\s*child: CircleAvatar\(\s*backgroundColor: Color\(0xFFD94A38\),\s*radius: 24,\s*child: Icon\(\s*Icons\.play_arrow,\s*color: Colors\.white,\s*size: 28,\s*\),\s*\),\s*\),\s*\)'''

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
                    )'''

c = re.sub(yt_regex, yt_replacement, c)

with open('lib/recipe_detail.dart', 'w', encoding='utf-8') as f:
    f.write(c)
