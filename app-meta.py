import json

with open('templates.json', 'r') as f:
    data = json.load(f)

apps = set()
appCategories = set()
for record in data['templates']:
    name = record['title'].replace('{shmolf}', '').strip()
    apps.add(name)

    categories = record['categories']
    appCategories.update(categories)

print('Apps:', '\n- '.join([''] + sorted(apps)))
print('Categories:', '\n- '.join([''] + sorted(appCategories)))
