
from unicodedata import name

team = {1: {'name': 'blah', 'age': '44', 'sex': 'Male'},
          2: {'name': 'boom', 'age': '64', 'sex': 'Female'}}
team.update({3:{'name':'ahead','age':'17','sex':'NA'}})

print(team[2])
print(team[1]['name'])
for i,k in team.items():
    print('+++++++++++++++++++++')
    print(i)
    for j in k:
        print(f"{j.capitalize()}:{k[j].upper()}")
    print('+++++++++++++++++++++')
del team[2]

print('After removing - ')
print(team)

#keys and values concept
for i,k in team.items():
    print(team[i])
    print(team[i].keys())
    print(team[i].values())
    
    for j in k:
        print(j)
print("values()")
# Using pop() to remove a dict. pair
for v in team.values():
    print(v)
    for i in v:
        print(f"{i}:{v[i]}")

# Using pop() to remove a dict. pair
team2={'name': 'blah', 'age': '44', 'sex': 'Male'}
removeValue=team2.pop('name')
print(team2)
