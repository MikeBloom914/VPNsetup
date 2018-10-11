"""REPLACE IP ADDRESS WITH NEW ONE"""

ssh root@104.248.77.45

adduser bloom
usermod -aG sudo bloom

su - bloom

mkdir ~/.ssh
chmod 700 ~/.ssh

nano ~/.ssh/authorized_keys
"""Open new window on local"""

# ON LOCAL MACHINE
cat ~/.ssh/id_rsa.pub
##copy key##

chmod 600 ~/.ssh/authorized_keys
exit
#once to return to root

##dont have to do in 16...
##sudo nano /etc/ssh/sshd_config

##find line for Password Authentications... make no
##PasswordAuthentication no ##

##PubkeyAuthentication yes
##ChallengeResponseAuthentication no
##save and exit###

sudo systemctl reload sshd

##test login##

ssh bloom@104.248.77.45

# (exit other logged in session)

sudo ufw app list
"""type in Password"""

sudo ufw allow OpenSSH
sudo ufw enable
sudo ufw status
"""enter in y"""

##DONE WITH BASIC SETUP OF SERVER##

############APP SETUP###########
##wait


sudo apt-get update
sudo apt-get install python3-pip python3-dev nginx

sudo pip3 install virtualenv

mkdir ~/myproject
cd ~/myproject
virtualenv myprojectenv

source myprojectenv/bin/activate

pip3 install uwsgi
pip3 install flask
pip3 install plotly
pip3 install dash
pip3 install dash_core_components
pip3 install dash_html_components
pip3 install dash_table_experiments
pip3 install colorlover
pip3 install pandas
pip3 install pandas_datareader
pip3 install sklearn
pip3 install websocket
pip3 install websocket-client

sudo nano ~/myproject/myproject.py

###copy and paste main file###

sudo ufw allow 5000
"""On Local Machine"""
scp -r "-r for Folder/ALL FILES NEEDED" to  bloom@104.248.67.189:/tmp

cd /tmp

mv "FILES" /home/bloom/myproject
"""BACK TO VIRTUAL"""

python3 myproject.py

"""on local to test"""
http://104.248.77.45:5000

nano ~/myproject/wsgi.py

###copy and paste file###
# from myproject import app

# if __name__ == "__main__":
#    app.run()

####

uwsgi --socket 0.0.0.0:5000 --protocol=http -w wsgi:app

#go to domain:5000 for test
#ctrl C

deaactivate


nano ~/myproject/myproject.ini


## copy and paste ##

sudo nano /etc/systemd/system/myproject.service

##copy and paste ##

sudo systemctl start myproject
sudo systemctl enable myproject

sudo nano /etc/nginx/sites-available/myproject

## place in
server {
    listen 80;
    server_name 104.248.67.189;
###replace server_domain with IP###. come back to change to website
    location / {
        include uwsgi_params;
        uwsgi_pass unix:/home/bloom/myproject/myproject.sock;
    }
}
###
sudo ln -s /etc/nginx/sites-available/myproject /etc/nginx/sites-enabled

sudo nginx -t
sudo systemctl restart nginx

sudo ufw delete allow 5000
sudo ufw allow 'Nginx Full'

##test by going to http://domain


sudo systemctl reload nginx

cd /tmp

mv CryptosAbyss/ ~

cd /home/bloom

