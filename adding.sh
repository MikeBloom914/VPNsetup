
#on virtual#

sudo apt-get -y install python3-pip && sudo pip3 install virtualenv

pip3 install flask

#exit#

#on local#
scp -P 6174 -r WebTrader bloom@159.203.178.23:/tmp

ssh -p 6174 bloom@159.203.178.23


#on virtual#

sudo firewall-cmd --add-port=5500/tcp --permanent

sudo systemctl reload firewalld

cd /tmp

mv WebTrader/ ~
