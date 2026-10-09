# Fix api_service.dart
with open('lib/api_service.dart', 'r', encoding='utf-8') as f:
    c = f.read()

old_steps = "steps = meal.strInstructions!.split(RegExp(r'\\n|\\r\\n')).where((s) => s.trim().isNotEmpty).toList();"
new_steps = """
      steps = meal.strInstructions!
          .split(RegExp(r'\\n|\\r\\n'))
          .map((s) => s.trim())
          .where((s) {
            if (s.isEmpty) return false;
            // Filter out lines that are just "step 1", "STEP 2", "1.", etc.
            final lower = s.toLowerCase();
            if (RegExp(r'^step\\s*\\d+$').hasMatch(lower)) return false;
            if (RegExp(r'^\\d+[\\.\\)]?$').hasMatch(lower)) return false;
            return true;
          })
          .toList();
"""

c = c.replace(old_steps, new_steps)

with open('lib/api_service.dart', 'w', encoding='utf-8') as f:
    f.write(c)

# Fix recipe_detail.dart
import re
with open('lib/recipe_detail.dart', 'r', encoding='utf-8') as f:
    c2 = f.read()

# Replace canLaunchUrl with direct launchUrl
old_launch = r'''if \(await canLaunchUrl\(uri\)\) \{[\s\S]*?await launchUrl\(uri\);[\s\S]*?\} else \{[\s\S]*?if \(mounted\) \{[\s\S]*?ScaffoldMessenger\.of\(context\)\.showSnackBar\([\s\S]*?const SnackBar\(content: Text\('Could not open video\.'\)\),[\s\S]*?\);[\s\S]*?\}[\s\S]*?\}'''
new_launch = """
                          try {
                            if (!await launchUrl(uri, mode: LaunchMode.externalApplication)) {
                              throw 'Could not launch';
                            }
                          } catch (e) {
                            if (mounted) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(content: Text('Could not open video.')),
                              );
                            }
                          }
"""

c2 = re.sub(old_launch, new_launch, c2)
c2 = c2.replace('title: "Step ${entry.key + 1}",', 'title: "Step",')

with open('lib/recipe_detail.dart', 'w', encoding='utf-8') as f:
    f.write(c2)
