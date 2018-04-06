#______________________________________________________________________________#
# $$$$$$$$$$$$$$$$$$$$|!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!|$$$$$$$$$$$$$$$$$$$$ #
#    $$$$$$$$$$$$$$$$$|!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!|$$$$$$$$$$$$$$$$$    #
#       $$$$$$$$$$$$$$|>>>|                          |<<<|$$$$$$$$$$$$$$       #
#          $$$$$$$$$$$|>>>|                       	 |<<<|$$$$$$$$$$$          #
#       $$$$$$$$$$$$$$|>>>|    Making Life Easier    |<<<|$$$$$$$$$$$$$$       #
#    $$$$$$$$$$$$$$$$$|>>>|          @Bloom          |<<<|$$$$$$$$$$$$$$$$$    #
# $$$$$$$$$$$$$$$$$$$$|>>>|                          |<<<|$$$$$$$$$$$$$$$$$$$$ #
#______________________________________________________________________________#
#                                                                              #
# You will need the following information:                                     #
# ~ your email address (hereafter: <email_addr>)                               #
# ~ your server's internet protocol address (hereafter: <vps_ip_addr>)         #
# ~ your server's name (hereafter: <vps_name>)                                 #
#                                                                              #
# Be advised:                                                                  #
# ~ <os_username> must be a string that is not "root"                          #
# ~ <os_password> should be a string that is longer than eight characters      #
# ~ <defined_ssh_port> must be an integer that is between 1024 and 65535       #
#                                                                              #
################################################################################

# ::|\ _______ /|::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::: #
# ::| |       | |::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::: #
# ::| | local | |::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::: #
# ::| !_______! |::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::: #
# ::!/         \!::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::: #

#!usr/bin/env python3

import os
import time


try:
    os.remove('/Users/bloom/byte/vmsetup/myfile.sh' and '/Users/bloom/byte/vmsetup/start.sh' and '/Users/bloom/byte/vmsetup/vps_start.sh' and '/Users/bloom/byte/vmsetup/local.sh' and '/Users/bloom/byte/vmsetup/remote.sh' and '/Users/bloom/byte/vmsetup/end.sh' and '/Users/bloom/byte/vmsetup/login.sh')
except OSError:
    pass


email = input("Enter email address: ")
vps_address = input("Enter servers ip address: ")
vps_name = input("Enter servers name: ")

username = input("Enter OS username: ")
password = input("Enter OS password: ")
ssh_port = input("Enter port # (bet 1024 and 65535): ")


replacements = {'<email_addr>': email, '<vps_ip_addr>': vps_address, '<vps_name>': vps_name,
                '<os_username>': username, '<os_password>': password, '<defined_ssh_port>': ssh_port}

lines = []

with open('/Users/bloom/byte/vmsetup/myprocedure.sh', 'r+') as f:
    for line in f:
        for key, value in replacements.items():
            line = line.replace(key, value)
        lines.append(line)

os.system('touch /Users/bloom/byte/vmsetup/myfile.sh')

with open('/Users/bloom/byte/vmsetup/myfile.sh', 'r+') as outf:
    for line in lines:
        outf.write(line)

outf.close()


os.system('touch start.sh')
os.system("sed -n '22,42p;44q' myfile.sh > start.sh")

os.system('touch vps_start.sh')
os.system("sed -n '43,65p;67q' myfile.sh > vps_start.sh")

os.system('touch local.sh')
os.system("sed -n '66,78p;80q' myfile.sh > local.sh")

os.system('touch remote.sh')
os.system("sed -n '79,113p;115q' myfile.sh > remote.sh")

os.system('touch end.sh')
os.system("sed -n '114,289p;291q' myfile.sh > end.sh")

os.system('touch login.sh')
os.system("sed -n '290,294p;296q' myfile.sh > login.sh")

os.system('bash start.sh')

os.system('bash local.sh')

os.system('bash login.sh')
