################################################################################
#																			   #
# Make sure you are opening this file from the same directory your python file,#
# 'myprocedure.py file' is in, as well as where it grabs this file from in the #
# two 'with open' lines inside the 'myprocedure.py' 						   #
#																		 	   #	
#!!!!!!!!!!!!!!!!!!!!!!!!!READ ABOVE BEFORE CONTINUING!!!!!!!!!!!!!!!!!!!!!!!!!#
#!!!!!! JUST RUN THE 'myprocedure.py' FILE AND ENTER IN YES WHEN PROMPTED!!!!!!#

#ssh-keygen -t rsa

sh -c 'echo "bloom:car" >> ~/.credentials'

#cat ~/.ssh/id_rsa.pub   #to get public key if a new one

scp vps_start.sh root@159.89.91.203:/root/
scp remote.sh root@159.89.91.203:/root/
scp end.sh root@159.89.91.203:/root/
ssh root@159.89.91.203 'bash vps_start.sh'
#ssh -o "StrictHostKeyChecking no"

