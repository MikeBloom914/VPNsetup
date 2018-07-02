
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
#																			   #
# Make sure you are opening this file from the same directory your python file,#
# 'myprocedure.py file' is in, as well as where the myprocedure.sh file is in  #
#																		 	   #
#!!!!!!!!!!!!!!!!!!!!!!!!!READ ABOVE BEFORE CONTINUING!!!!!!!!!!!!!!!!!!!!!!!!!#
#!!!!!! JUST RUN THE 'myprocedure.py' FILE AND ENTER IN YES WHEN PROMPTED!!!!!!#

#ssh-keygen -t rsa

sh -c 'echo "<os_username>:<os_password>" >> ~/.credentials'

#cat ~/.ssh/id_rsa.pub   #to get public key if a new one

scp vps_start.sh root@<vps_ip_addr>:/root/
scp remote.sh root@<vps_ip_addr>:/root/
scp end.sh root@<vps_ip_addr>:/root/
ssh root@<vps_ip_addr> 'bash vps_start.sh'
#ssh -o "StrictHostKeyChecking no"


# ::|\ ________ /|:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::: #
# ::| |        | |:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::: #
# ::| | remote | |:::::::::::ls::::::::::::::::::::::::::::::::::::::::::::::::: #
# ::| !________! |:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::: #
# ::!/          \!:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::: #

sh -c 'echo "set const" >> .nanorc'

sh -c 'echo "set tabsize 8" >> .nanorc'

sh -c 'echo "set tabstospaces" >> .nanorc'

adduser --disabled-password --gecos "" <os_username>

usermod -aG sudo <os_username>

cp '.nanorc' /home/<os_username>/

mkdir /etc/ssh/<os_username>

#exit


# ::|\ _______ /|::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::: #
# ::| |       | |::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::: #
# ::| | local | |::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::: #
# ::| !_______! |::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::: #
# ::!/         \!::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::: #

scp ~/.ssh/id_rsa.pub root@<vps_ip_addr>:/etc/ssh/<os_username>/authorized_keys

scp .credentials root@<vps_ip_addr>:/home/<os_username>/

ssh root@<vps_ip_addr> 'bash remote.sh'


# ::|\ ________ /|:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::: #
# ::| |        | |:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::: #
# ::| | remote | |:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::: #
# ::| !________! |:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::: #
# ::!/          \!:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::: #

chown -R <os_username>:<os_username> /etc/ssh/<os_username>

chmod 755 /etc/ssh/<os_username>

chmod 644 /etc/ssh/<os_username>/authorized_keys

sed -i -e '/^#AuthorizedKeysFile/s/^.*$/AuthorizedKeysFile \/etc\/ssh\/<os_username>\/authorized_keys/' /etc/ssh/sshd_config

sed -i -e '/^PermitRootLogin/s/^.*$/PermitRootLogin no/' /etc/ssh/sshd_config

sed -i -e '/^PasswordAuthentication/s/^.*$/PasswordAuthentication no/' /etc/ssh/sshd_config

sh -c 'echo "" >> /etc/ssh/sshd_config'

sh -c 'echo "" >> /etc/ssh/sshd_config'

sh -c 'echo "# Added by Katabasis build process" >> /etc/ssh/sshd_config'

sh -c 'echo "AllowUsers <os_username>" >> /etc/ssh/sshd_config'

apt-get update ## Added by me

systemctl reload sshd

apt-get -y install firewalld ntp nginx fail2ban postgresql postgresql-contrib

bash end.sh



systemctl start firewalld

firewall-cmd --reload

systemctl enable firewalld

sed -i -e '/^Port/s/^.*$/Port <defined_ssh_port>/' /etc/ssh/sshd_config

firewall-cmd --add-port <defined_ssh_port>/tcp --permanent

firewall-cmd --reload

systemctl reload sshd

timedatectl set-timezone America/New_York

fallocate -l 3G /swapfile

chmod 600 /swapfile

mkswap /swapfile

sh -c "echo '/swapfile none swap sw 0 0' >> /etc/fstab"

sysctl vm.swappiness=10

sh -c "echo 'vm.swappiness=10' >> /etc/sysctl.conf"

sysctl vm.vfs_cache_pressure=30

sh -c 'echo "vm.vfs_cache_pressure=30" >> /etc/sysctl.conf'

sh -c 'echo "log_format timekeeper \$remote_addr - \$remote_user [\$time_local] " >> /etc/nginx/conf.d/timekeeper-log-format.conf'

sed -i "s/\$remote_addr/\'\$remote_addr/" /etc/nginx/conf.d/timekeeper-log-format.conf

sed -i "s/_local] /_local] \'/" /etc/nginx/conf.d/timekeeper-log-format.conf

sh -c 'echo "                      \$request \$status \$body_bytes_sent " >> /etc/nginx/conf.d/timekeeper-log-format.conf'

sed -i "s/\$request/\'\"\$request\"/" /etc/nginx/conf.d/timekeeper-log-format.conf

sed -i "s/_sent /_sent \'/" /etc/nginx/conf.d/timekeeper-log-format.conf

sh -c 'echo "                      \$http_referer \$http_user_agent \$http_x_forwarded_for \$request_time;" >> /etc/nginx/conf.d/timekeeper-log-format.conf'

sed -i "s/\$http_referer/\'\"\$http_referer\"/" /etc/nginx/conf.d/timekeeper-log-format.conf

sed -i "s/\$http_user_agent/\"\$http_user_agent\"/" /etc/nginx/conf.d/timekeeper-log-format.conf

sed -i "s/\$http_x_forwarded_for/\"\$http_x_forwarded_for\"/" /etc/nginx/conf.d/timekeeper-log-format.conf

sed -i "s/_time;/_time\';/" /etc/nginx/conf.d/timekeeper-log-format.conf

sh -c 'echo "geoip_country /usr/share/GeoIP/GeoIP.dat;" >> /etc/nginx/conf\.d/geoip.conf'

sed -i '/# Default server configuration/a \}' /etc/nginx/sites-available/default

sed -i '/# Default server configuration/a US yes;' /etc/nginx/sites-available/default

sed -i '/# Default server configuration/a default no;' /etc/nginx/sites-available/default

sed -i '/# Default server configuration/a map \$geoip_country_code \$allowed_country \{' /etc/nginx/sites-available/default

sed -i '/# Default server configuration/a \

' /etc/nginx/sites-available/default

sed -i 's/US yes;/        US yes;/' /etc/nginx/sites-available/default

sed -i 's/default no;/        default no;/' /etc/nginx/sites-available/default

sed -i '/listen \[::\]:80 default_server;/a \}#tmp_id_1' /etc/nginx/sites-available/default

sed -i '/listen \[::\]:80 default_server;/a return 444;' /etc/nginx/sites-available/default

sed -i '/listen \[::\]:80 default_server;/a if (\$allowed_country = no) \{' /etc/nginx/sites-available/default

sed -i '/listen \[::\]:80 default_server;/a \

' /etc/nginx/sites-available/default

sed -i 's/\}#tmp_id_1/        \}/' /etc/nginx/sites-available/default

sed -i 's/return 444;/                return 444;/' /etc/nginx/sites-available/default

sed -i 's/if (\$allowed_country = no)/        if (\$allowed_country = no)/' /etc/nginx/sites-available/default

sed -i '/listen \[::\]:80 default_server;/a access_log \/var\/log\/nginx\/server-block-1-access\.log timekeeper gzip;' /etc/nginx/sites-available/default

sed -i 's/access_log \/var\/log\/nginx\/server-block-1-access\.log timekeeper gzip;/        access_log \/var\/log\/nginx\/server-block-1-access\.log timekeeper gzip;/' /etc/nginx/sites-available/default

sed -i '/access_log \/var\/log\/nginx\/server-block-1-access\.log timekeeper gzip;/a error_log \/var\/log\/nginx\/server-block-1-error\.log;' /etc/nginx/sites-available/default

sed -i 's/error_log \/var\/log\/nginx\/server-block-1-error\.log;/        error_log \/var\/log\/nginx\/server-block-1-error\.log;/' /etc/nginx/sites-available/default

sed -i '/listen \[::\]:80 default_server;/a \

' /etc/nginx/sites-available/default

sh -c "echo 'gzip_vary on;' >> /etc/nginx/conf.d/gzip.conf"

sh -c "echo 'gzip_proxied any;' >> /etc/nginx/conf.d/gzip.conf"

sh -c "echo 'gzip_comp_level 6;' >> /etc/nginx/conf.d/gzip.conf"

sh -c "echo 'gzip_buffers 16 8k;' >> /etc/nginx/conf.d/gzip.conf"

sh -c "echo 'gzip_http_version 1.1;' >> /etc/nginx/conf.d/gzip.conf"

sh -c "echo 'gzip_min_length 256;' >> /etc/nginx/conf.d/gzip.conf"

sh -c "echo 'gzip_types text/plain text/css application/json application/x-javascript text/xml application/xml application/xml+rss text/javascript application/javascript application/vnd.ms-fontobject application/x-font-ttf font/opentype image/svg+xml image/x-icon;' >> /etc/nginx/conf.d/gzip.conf"

nginx -t

systemctl start nginx

firewall-cmd --permanent --zone=public --add-service=http

firewall-cmd --permanent --zone=public --add-service=https

firewall-cmd --reload

systemctl enable nginx

systemctl enable fail2ban

sh -c 'echo "[DEFAULT]" >> /etc/fail2ban/jail.local'

sh -c 'echo "bantime = 7200" >> /etc/fail2ban/jail.local'

sh -c 'echo "findtime = 1200" >> /etc/fail2ban/jail.local'

sh -c 'echo "maxretry = 3" >> /etc/fail2ban/jail.local'

sh -c 'echo "destemail = <email_addr>" >> /etc/fail2ban/jail.local'

sh -c 'echo "sendername = security@<vps_name>" >> /etc/fail2ban/jail.local'

sh -c 'echo "banaction = iptables-multiport" >> /etc/fail2ban/jail.local'

sh -c 'echo "mta = sendmail" >> /etc/fail2ban/jail.local'

sh -c 'echo "action = %(banaction)s[name=%(__name__)s, bantime=\"%(bantime)s\", port=\"%(port)s\", protocol=\"%(protocol)s\", chain=\"%(chain)s\"], %(mta)s-whois-lines[name=%(__name__)s, dest=\"%(destemail)s\", logpath=%(logpath)s, chain=\"%(chain)s\"]" >> /etc/fail2ban/jail.local'

sh -c 'echo "" >> /etc/fail2ban/jail.local'

sh -c 'echo "[sshd]" >> /etc/fail2ban/jail.local'

sh -c 'echo "enabled = true" >> /etc/fail2ban/jail.local'

sh -c 'echo "" >> /etc/fail2ban/jail.local'

sh -c 'echo "" >> /etc/fail2ban/jail.local'

sh -c 'echo "[sshd-ddos]" >> /etc/fail2ban/jail.local'

sh -c 'echo "enabled = true" >> /etc/fail2ban/jail.local'

sh -c 'echo "" >> /etc/fail2ban/jail.local'

sh -c 'echo "[nginx-http-auth]" >> /etc/fail2ban/jail.local'

sh -c 'echo "enabled = true" >> /etc/fail2ban/jail.local'

systemctl restart fail2ban

cat /home/<os_username>/.credentials | chpasswd

rm /home/<os_username>/.credentials

systemctl status fail2ban firewalld nginx ntp sshd


ssh -p <defined_ssh_port> <os_username>@<vps_ip_addr>


