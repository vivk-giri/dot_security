import re
txt = "MY IP Address is 172.44.55.66"
#Best way to define and test pattern here : https://regex101.com
reg_pattern=r"is\s(.*?)$"
match = re.search(reg_pattern, txt)
if match != None:
    print(match.group(1))

#Using Findall
reg="(\d.+\d.+\d.)"
match=re.findall(reg,txt)
if match:
    print(match[0])