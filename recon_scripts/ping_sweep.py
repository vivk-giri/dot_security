#############################################################
## Example how to run this script 
##python ping_sweep.py
##Provide the Starting IP Address: 192.168.1.0
##Enter the Starting IP Addr : 1
##Enter the Last IP Addr : 15
##############################################################

import os
import platform
import socket,re
from datetime import datetime

#Taking input from user e.g starting subnet
IP_Start = input("Provide the Starting IP Address: ")
oct_ip= IP_Start.split('.')
a = '.'

#Set Starting IP addr and defined last IP to create the IP range
sub1 = oct_ip[0] + a + oct_ip[1] + a + oct_ip[2] + a
st1 = int(input("Enter the Starting IP Addr : "))
en1 = int(input("Enter the Last IP Addr : "))
en1 = en1 + 1

#Check current machine OS
operating_system = platform.system()

if (operating_system == "Windows"):
   ping_st = "ping -n 1 "
elif (operating_system == "Linux"):
   ping_st = "ping -c 1 "
else :
   ping_st = "ping -c 1 "
t1 = datetime.now()
print ("Scanning in intiated:")

reg1='TTL=(.*?)$'
os_type='linux'
for ip in range(st1,en1):
   addr = sub1 + str(ip)
   comm = ping_st + addr
   response = os.popen(comm)
   
   for line in response.readlines():
      if (line.count("TTL")):
          res=re.findall(reg1,line)
          if res:
              ttlvalue=res[0]
              ttlvalue=int(float(ttlvalue))
              #Making Decision of OS based on TTL
              os_type="Windows" if ttlvalue > 90 else os_type
              print(f'OS type on the Host : {addr} could be - {os_type}')
              
          print (addr, "--> is Live")
          try:
              hostn=socket.gethostbyaddr(addr) #will work only if it has reverse DNS 
              print("Hostname :- ",hostn)
          except:
             pass
    
         
t2 = datetime.now()
total = t2 - t1
print ("Scanning completed in: ",total)
