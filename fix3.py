import re
with open('lib/recipe_detail.dart', 'r', encoding='utf-8') as f:
    c = f.read()

# Fix the steps count
c = c.replace('" Steps"', '"${_recipe.steps.length} Steps"')
c = c.replace('"Step "', '"Step"')

# Fix the Video Tutorial container
vid_regex = r'const SizedBox\(height: 24\),\s*const Text\(\s*"Video Tutorial",\s*style: TextStyle\(\s*fontSize: 16,\s*fontWeight: FontWeight\.bold,\s*\),\s*\),\s*const SizedBox\(height: 12\),\s*GestureDetector\('
vid_replacement = r'if (_recipe.youtubeUrl.isNotEmpty) ...[\nconst SizedBox(height: 24),\nconst Text("Video Tutorial", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),\nconst SizedBox(height: 12),\nGestureDetector('

c = re.sub(vid_regex, vid_replacement, c)

# find the end of the gesture detector (it is right before ],)
end_regex = r'\),\s*\),\s*\),\s*\]'
end_replacement = r'),\n),\n),\n],\n]'

c = re.sub(r'\),\n\s*\)\n\s*\)\n\s*\]', '),),],]', c) # hacky, let us use ast or replace file content

with open('lib/recipe_detail.dart', 'w', encoding='utf-8') as f:
    f.write(c)
