import http
import socket
import re
from urllib.request import urlopen

def get_privateIP():
    ip=socket.gethostbyname(socket.gethostname())
    print(f"Privaet IPv4 : {ip}")

def get_publicIP():
    data=str(urlopen('http://checkip.dyndns.com/').read())
    reg=re.compile(r'Address: (\d+.\d+.\d+.\d+)').search(data).group(1)
    print(f"Public IP : {reg}")
get_privateIP()
get_publicIP()