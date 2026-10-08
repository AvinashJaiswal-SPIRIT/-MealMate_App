import os
import re

def add_comments(filepath):
    with open(filepath, 'r', encoding='utf-8') as f:
        content = f.read()

    comments = {
        # General structure
        r'(class \w+ extends (Stateful|Stateless)Widget \{)': r'// This class defines a UI component.\n\1',
        r'(Widget build\(BuildContext context\) \{)': r'// The build method constructs the UI for this widget.\n  \1',
        r'(void initState\(\) \{)': r'// initState is called once when the widget is created. Good for setup.\n  \1',
        r'(void dispose\(\) \{)': r'// dispose is called when the widget is destroyed. Good for cleanup.\n  \1',
        
        # Specific files: home_tab.dart
        r'(const MealMateHeader\(\),)': r'// Displays the custom top header with the app logo and user avatar.\n                \1',
        r'(child: TextField\()': r'// The search bar input field.\n                  \1',
        r'(const Text\(\s*"Popular Recipes")': r'// Section title for Popular Recipes.\n                  \1',
        r'(const Text\(\s*"Explore Categories")': r'// Section title for the horizontal list of Categories.\n                  \1',
        r'(const Text\(\s*"Don\'t know what to cook\?")': r'// The "Surprise Me" banner section.\n                          \1',
        r'(const Text\(\s*"Recommended for You")': r'// Section title for Recommended Recipes grid.\n                  \1',
        r'(GridView\.builder\()': r'// Builds a 2-column grid of recipes dynamically.\n                      \1',
        
        # liked_tab.dart
        r'(const Text\(\s*"Liked Meals")': r'// Page title for the Liked Meals tab.\n                        \1',
        r'(ListView\.builder\()': r'// Renders the list of liked recipes dynamically.\n                      \1',
        r'(\s+)(for \(var r in globalLikedRecipes\) \{)': r'\1// Loops through all liked recipes and sets isLiked to false to clear them.\1\2',
        
        # recipe_detail.dart
        r'(Stack\(\s*children: \[\s*ClipRRect\(\s*borderRadius: const BorderRadius\.vertical\()': r'// Stack is used here to overlay the time/rating tags on top of the recipe image.\n            \1',
        r'(\s+)(FloatingTag\()': r'\1// Displays a small floating tag (e.g., for time, rating, calories).\1\2',
        r'(\s+)(RecipeChip\()': r'\1// A small chip to display the recipe category.\1\2',
        r'(\s+)(StatBox\()': r'\1// Displays a statistic box for servings, prep time, etc.\1\2',
        r'(\s+)(StepCard\()': r'\1// Displays a single step in the recipe instructions.\1\2',
        r'(\s+)(IngredientRow\()': r'\1// Displays a single ingredient row with a checkbox.\1\2',
        r'(floatingActionButton: Container\()': r'// This is the bottom floating bar containing the "Like" and "Start Cooking" buttons.\n      \1',
        
        # login.dart & signup.dart
        r'(\s+)(AuthLabel\()': r'\1// Label for an input field in the authentication forms.\1\2',
        r'(\s+)(AuthTextField\()': r'\1// Text input field specifically styled for authentication forms.\1\2',
        r'(\s+)(PasswordStrengthBar\()': r'\1// Visually indicates the strength of the entered password.\1\2',
        r'(\s+)(TermsCheckboxRow\()': r'\1// Checkbox row for agreeing to terms and privacy policy.\1\2',
        r'(\s+)(PrimaryButton\()': r'\1// The main submission button for the form.\1\2',
        r'(\s+)(SocialButton\()': r'\1// Button for third-party social logins (e.g., Google, Apple).\1\2',
        r'(\s+)(GuaranteeBox\()': r'\1// Banner displaying the "Free Forever Guarantee".\1\2',
        r'(void _checkPasswordStrength\(\) \{)': r'// Evaluates the password string and calculates a strength score (Weak/Medium/Strong).\n  \1',
        
        # state management
        r'(\s+)(setState\(\(\) \{)': r'\1// Triggers a UI update with the new state values.\1\2',
    }

    original = content
    for pattern, replacement in comments.items():
        # Avoid duplicating comments if we already inserted them
        if replacement.replace(r'\n', '\n').replace(r'\1', '').replace(r'\2', '').strip() not in content:
             content = re.sub(pattern, replacement, content)

    if content != original:
        with open(filepath, 'w', encoding='utf-8') as f:
            f.write(content)
        print(f"Added comments to {filepath}")

for root, dirs, files in os.walk('lib'):
    for file in files:
        if file.endswith('.dart'):
            add_comments(os.path.join(root, file))
