#! /bin/bash

# apt-get

## Update all the things
sudo apt-get -y update

## Build essential ssl and git
sudo apt-get -y install build-essential libssl-dev git-core

## Curl
sudo apt-get -y install curl

## Install Python
sudo apt-get -y install python-dev

## Install PostgreSQL
sudo apt-get -y install libpq-dev postgresql

## Install redis
sudo apt-get -y install redis-server

## Install nginx
sudo apt-get -y install nginx

## Install MongoDB
sudo apt-get -y install mongo

## Install MySQL
sudo apt-get -y install mysql-server-5.6 mysql-client-5.6

## Install Docker.io
sudo apt-get -y install docker.io

## Install fail2ban
# sudo apt-get install -y fail2ban

## Install unattended-upgrades
sudo apt-get install -y unattended-upgrades

# Node.js
git clone https://github.com/creationix/nvm.git /home/vagrant/.nvm
echo "[ -s /home/vagrant/.nvm/nvm.sh ] && . /home/vagrant/.nvm/nvm.sh # This loads NVM" >> /home/vagrant/.bash_profile
source /home/vagrant/.nvm/nvm.sh

nvm install 0.10
nvm alias default 0.10

sudo chown -R vagrant:vagrant /home/vagrant/.nvm/

source /home/vagrant/.bash_profile

# Node.js Libs

## Gulp CLI
npm install -g gulp

## Ember CLI
npm install -g ember-cli

## Grunt CLI
npm install -g grunt-cli

## Bower
npm install -g bower

# Docker.io

# Heroku
wget -qO- https://toolbelt.heroku.com/install-ubuntu.sh | sh

# Nginx config
sudo mv /etc/nginx/nginx.conf /etc/nginx/nginx.conf.old

sudo cat > /etc/nginx/nginx.conf <<EOF
"user www-data;
worker_processes 4;
pid /var/run/nginx.pid;

events {
    worker_connections 768;
    # multi_accept on;
}

http {

    ##
    # Basic Settings
    ##

    sendfile on;
    tcp_nopush on;
    tcp_nodelay on;
    keepalive_timeout 65;
    types_hash_max_size 2048;
    # server_tokens off;

    # server_names_hash_bucket_size 64;
    # server_name_in_redirect off;

    include /etc/nginx/mime.types;
    default_type application/octet-stream;

    ##
    # Logging Settings
    ##

    access_log /var/log/nginx/access.log;
    error_log /var/log/nginx/error.log;

    ##
    # Gzip Settings
    ##

    gzip on;
    gzip_disable \"msie6\";

    # gzip_vary on;
    gzip_proxied any;
    # gzip_comp_level 6;
    # gzip_buffers 16 8k;
    gzip_http_version 1.1;
    gzip_types text/plain text/css application/json application/x-javascript text/xml application/xml application/xml+rss text/javascript;

    ##
    # nginx-naxsi config
    ##
    # Uncomment it if you installed nginx-naxsi
    ##

    #include /etc/nginx/naxsi_core.rules;

    ##
    # nginx-passenger config
    ##
    # Uncomment it if you installed nginx-passenger
    ##

    #passenger_root /usr;
    #passenger_ruby /usr/bin/ruby;

    ##
    # Virtual Host Configs
    ##

    include /etc/nginx/conf.d/*.conf;
    include /etc/nginx/sites-enabled/*;
}


#mail {
#   # See sample authentication script at:
#   # http://wiki.nginx.org/ImapAuthenticateWithApachePhpScript
#
#   # auth_http localhost/auth.php;
#   # pop3_capabilities \"TOP\" \"USER\";
#   # imap_capabilities \"IMAP4rev1\" \"UIDPLUS\";
#
#   server {
#       listen     localhost:110;
#       protocol   pop3;
#       proxy      on;
#   }
#
#   server {
#       listen     localhost:143;
#       protocol   imap;
#       proxy      on;
#   }
#}"
EOF

# pip
sudo wget https://bitbucket.org/pypa/setuptools/raw/bootstrap/ez_setup.py
sudo python ez_setup.py
sudo easy_install pip

# PostgreSQL
sudo -u postgres createdb development
sudo -u postgres psql -U postgres -d postgres -c "alter user postgres with password 'password';"
echo "listen_addresses = '*'" | sudo -u postgres tee -a /etc/postgresql/9.1/main/postgresql.conf
echo "host all all 0.0.0.0/0 md5" | sudo -u postgres tee -a /etc/postgresql/9.1/main/pg_hba.conf
sudo service postgresql restart

# Profile
echo "alias ls='ls -lah --color'" >> /home/vagrant/.bash_profile
echo "export GREP_OPTIONS='--color=auto'" >> /home/vagrant/.bash_profile
echo "export CLICOLOR=1" >> /home/vagrant/.bash_profile
echo "export LS_COLORS='di=33:fi=0:ln=31:pi=5:so=5:bd=5:cd=5:or=31:mi=0:ex=35'" >> /home/vagrant/.bash_profile

# prompt
PROMPTCONFIG=$(cat <<EOM
if [[ \$COLORTERM = gnome-* && \$TERM = xterm ]] && infocmp gnome-256color >/dev/null 2>&1; then
    export TERM=gnome-256color
    elif infocmp xterm-256color >/dev/null 2>&1; then
        export TERM=xterm-256color
        fi

        txtblk='\e[0;30m' # Black - Regular
        txtred='\e[0;31m' # Red
        txtgrn='\e[0;32m' # Green
        txtylw='\e[0;33m' # Yellow
        txtblu='\e[0;34m' # Blue
        txtpur='\e[0;35m' # Purple
        txtcyn='\e[0;36m' # Cyan
        txtwht='\e[0;37m' # White

        bldblk='\e[1;30m' # Black - Bold
        bldred='\e[1;31m' # Red
        bldgrn='\e[1;32m' # Green
        bldylw='\e[1;33m' # Yellow
        bldblu='\e[1;34m' # Blue
        bldpur='\e[1;35m' # Purple
        bldcyn='\e[1;36m' # Cyan
        bldwht='\e[1;37m' # White

        unkblk='\e[4;30m' # Black - Underline
        undred='\e[4;31m' # Red
        undgrn='\e[4;32m' # Green
        undylw='\e[4;33m' # Yellow
        undblu='\e[4;34m' # Blue
        undpur='\e[4;35m' # Purple
        undcyn='\e[4;36m' # Cyan
        undwht='\e[4;37m' # White

        bakblk='\e[40m'   # Black - Background
        bakred='\e[41m'   # Red
        badgrn='\e[42m'   # Green
        bakylw='\e[43m'   # Yellow
        bakblu='\e[44m'   # Blue
        bakpur='\e[45m'   # Purple
        bakcyn='\e[46m'   # Cyan
        bakwht='\e[47m'   # White

        txtrst='\e[0m'    # Text Reset

        function parse_git_dirty() {
        [[ \$(git status 2> /dev/null | tail -n1) != "nothing to commit (working directory clean)" ]] && echo "*"
        }

        function parse_git_branch() {
        git branch --no-color 2> /dev/null | sed -e '/^[^*]/d' -e "s/* \(.*\)/\1\$(parse_git_dirty)/"
        }

        PS1="\[\${txtgrn}\]\u \[\${bldblu}\]at \[\${txtylw}\]\h \[\${bldblu}\]in \[\${bldred}\]\w\[\${bldblu}\]\$([[ -n \$(git branch 2> /dev/null) ]] && echo \" on \")\[\${txtpur}\]\$(parse_git_branch)\[\${bldblu}\]\n\$ \[\${txtrst}\]"
EOM
)
echo "$PROMPTCONFIG" >> /home/vagrant/.bash_profile

# redis
sudo sed -i 's/bind 127.0.0.1/# bind 127.0.0.1/g' /etc/redis/redis.conf
sudo echo 'vm.overcommit_memory = 1' | sudo tee -a /etc/sysctl.conf
sudo sysctl vm.overcommit_memory=1
sudo service redis-server restart

# ssh
## Disallow root SSH access
sudo sed -i 's/PermitRootLogin yes/PermitRootLogin no/g' /etc/ssh/sshd_config

## Disallow password authentication
sudo sed -i 's/#PasswordAuthentication yes/PasswordAuthentication no/g' /etc/ssh/sshd_config

## Restart ssh
sudo service ssh restart

# Go
mkdir /home/vagrant/go
wget -P /home/vagrant/ http://golang.org/dl/go1.3.linux-amd64.tar.gz

sudo tar -xzf go1.3.linux-amd64.tar.gz

export GOROOT=$HOME/go
export PATH=$PATH:$GOROOT/bin
