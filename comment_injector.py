import os
import re

def add_comments(filepath):
    with open(filepath, 'r', encoding='utf-8') as f:
        content = f.read()

    comments = {
        # Overall structural
        r'(\s+)(Scaffold\()': r'\1// SCENE ROOT: Scaffold provides the basic visual layout structure (app bar, body, bottom nav).\1\2',
        r'(\s+)(SafeArea\()': r'\1// SAFE AREA: Prevents UI from overlapping with system status bars or notches.\1\2',
        r'(\s+)(SingleChildScrollView\()': r'\1// SCROLL VIEW: Allows content to be scrolled vertically if it overflows the screen.\1\2',
        r'(\s+)(Column\()': r'\1// VERTICAL LAYOUT: Arranges child widgets in a top-to-bottom vertical line.\1\2',
        r'(\s+)(Row\()': r'\1// HORIZONTAL LAYOUT: Arranges child widgets in a left-to-right horizontal line.\1\2',
        r'(\s+)(Expanded\()': r'\1// EXPANDED: Forces this widget to fill the remaining available space within a Row or Column.\1\2',
        r'(\s+)(ListView\.builder\()': r'\1// DYNAMIC LIST: Renders a scrollable list of widgets efficiently on-demand.\1\2',
        r'(\s+)(GridView\.builder\()': r'\1// DYNAMIC GRID: Renders a scrollable 2D array of widgets efficiently on-demand.\1\2',
        r'(\s+)(Stack\()': r'\1// STACK OVERLAY: Places child widgets directly on top of each other (like layers).\1\2',
        r'(\s+)(Positioned\()': r'\1// ABSOLUTE POSITIONING: Controls the exact top/bottom/left/right placement inside a Stack.\1\2',
        r'(\s+)(ClipRRect\()': r'\1// ROUNDED CORNERS: Clips its child (usually an image) to have rounded corners.\1\2',
        
        # Interactions
        r'(\s+)(GestureDetector\()': r'\1// TAP TARGET: Makes any widget inside it clickable and detects gestures.\1\2',
        r'(\s+)(ElevatedButton\()': r'\1// SOLID BUTTON: A standard Material Design elevated button for primary actions.\1\2',
        r'(\s+)(TextField\()': r'\1// TEXT INPUT: Allows the user to type text from the keyboard.\1\2',
        
        # Styling / Containers
        r'(\s+)(Container\()': r'\1// BOX CONTAINER: A customizable box for padding, margins, borders, and background colors.\1\2',
        r'(\s+)(Padding\()': r'\1// SPACING: Adds empty space around its child widget.\1\2',
        r'(\s+)(SizedBox\()': r'\1// FIXED SPACING: Creates a fixed-size empty box (often used for spacing between widgets).\1\2',
        r'(\s+)(CircleAvatar\()': r'\1// CIRCULAR IMAGE: Displays an image or icon cropped into a circle (typically for profiles).\1\2',
        
        # Logic / State
        r'(\s+)(setState\(\(\) \{)': r'\1// STATE UPDATE: Notifies Flutter that a variable changed, triggering the screen to redraw.\1\2',
        r'(\s+)(Navigator\.push\()': r'\1// NAVIGATION: Pushes a new screen onto the stack (moves forward).\1\2',
        r'(\s+)(Navigator\.pop\()': r'\1// NAVIGATION: Pops the current screen off the stack (moves backward).\1\2',
    }

    original = content
    
    # Process line by line or pattern by pattern?
    # Because we are replacing blindly, we should make sure we don't duplicate.
    for pattern, replacement in comments.items():
        # A bit hacky: only replace if the comment string doesn't already exist right before it.
        # But regex sub will apply to all. Let's do a simple sub and clean up duplicates.
        content = re.sub(pattern, replacement, content)

    # Clean up multiple identical comments if they stacked up
    # We will remove a comment if the exact same comment appears again on the previous lines.
    lines = content.split('\n')
    cleaned_lines = []
    prev_comment = ""
    for line in lines:
        stripped = line.strip()
        if stripped.startswith('// ') and stripped == prev_comment:
            continue
        if stripped.startswith('// '):
            prev_comment = stripped
        else:
            prev_comment = ""
        cleaned_lines.append(line)
        
    content = '\n'.join(cleaned_lines)

    if content != original:
        with open(filepath, 'w', encoding='utf-8') as f:
            f.write(content)
        print(f"Annotated {filepath}")

for root, dirs, files in os.walk('lib'):
    for file in files:
        if file.endswith('.dart'):
            add_comments(os.path.join(root, file))
