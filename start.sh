################################################################################
#																			   #
# Make sure you are opening this file from the same directory your python file,#
# 'myprocedure.py file' is in, as well as where it grabs this file from in the #
# two 'with open' lines inside the 'myprocedure.py' 						   #
#																		 	   #	
#!!!!!!!!!!!!!!!!!!!!!!!!!READ ABOVE BEFORE CONTINUING!!!!!!!!!!!!!!!!!!!!!!!!!#
#!!!!!! JUST RUN THE 'myprocedure.py' FILE AND ENTER IN YES WHEN PROMPTED!!!!!!#

#ssh-keygen -t rsa

sh -c 'echo "bloom:bloom" >> ~/.credentials'

#cat ~/.ssh/id_rsa.pub   #to get public key if a new one

scp vps_start.sh root@167.99.48.165:/root/
scp remote.sh root@167.99.48.165:/root/
scp end.sh root@167.99.48.165:/root/
ssh root@167.99.48.165 'bash vps_start.sh'
#ssh -o "StrictHostKeyChecking no"

