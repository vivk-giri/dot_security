#######################################################
# To Run this script python3 scanNamp.py -I <ip>      #
# Port range also can be passed as argument           #
#######################################################

import argparse
import nmap
nm=nmap.PortScanner()
parser =argparse.ArgumentParser(description=" Provide IP and port") #creating agument parser
parser.add_argument('-I','--ip',type=str,required=True , help="Provide Ip address to scan")#adding argument
#parser.add_argument('-P','--port',type=str, required=True,help="please enter port/ort range")
args=parser.parse_args() #parsing argument
host=args.ip
#port=args.port
#print("IP:",host)
#result=nm.scan(host,port)
result=nm.scan(host)
#result=result.json()
#print(result)
#ports=nm[host]['tcp'].keys()
var2=result['scan']
for i,k in var2.items():
    for j in k:
        if j=='tcp':
            break
        print("{}:{}".format(j.capitalize(),k[j]))
        
        
for i,k in var2.items():
    for j in k:
        for t in k['tcp']:

            print("------------------------------\nPort:{} ".format(t))
            
            print()
            for v in k['tcp'][t]:
                print("{} : {}".format(v.capitalize(),k['tcp'][t][v]))
            #print(t['state'],t['name'],t['product'],t['version'])
            print('------------------------------') 
        break    

