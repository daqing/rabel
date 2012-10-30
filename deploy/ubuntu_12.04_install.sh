if [ -z "$1" -o -z "$2" ]; then
  echo -e "\033[1;31mUSAGE: $0 [mysql_password] [domain] \033[0m"
  echo -e "\033[1;32m--- example ---"
  echo -e "$0 e17c92a rabelapp.com \033[0m"
  exit
fi

MYSQL_PASSWD="$1"
MAIL_ADDRESS="$2"

sudo apt-get update
sudo apt-get install -y unzip curl aptitude vim debconf-utils
curl -L get.rvm.io | bash -s stable
source_rvm="source ~/.rvm/scripts/rvm"
echo "$source_rvm" >> ~/.bashrc
echo "$source_rvm" | bash
sudo apt-get install -y build-essential openssl \
libreadline6 libreadline6-dev \
curl git-core zlib1g zlib1g-dev libssl-dev libyaml-dev \
libsqlite3-0  libxml2-dev libxslt-dev \
autoconf libc6-dev ncurses-dev automake libtool bison g++ \
libmysqlclient-dev
sudo apt-get install -y graphicsmagick-libmagick-dev-compat
sudo apt-get install -y libmagickwand-dev
~/.rvm/bin/rvm install 1.9.3
echo "$source_rvm" | bash
rvm use 1.9.3 --default
sudo aptitude install -y memcached imagemagick nodejs nginx

cat <<MYSQL_PRESEED | sudo su -c debconf-set-selections
mysql-server-5.5 mysql-server/root_password password $MYSQL_PASSWD
mysql-server-5.5 mysql-server/root_password_again password $MYSQL_PASSWD
mysql-server-5.5 mysql-server/start_on_boot boolean true
MYSQL_PRESEED

sudo apt-get install -q -y mysql-server-5.5

cat <<POSTFIX_PRESEED | sudo su -c debconf-set-selections
postfix postfix/main_mailer_type select Internet Site
postfix postfix/mailname string $MAIL_ADDRESS
POSTFIX_PRESEED

sudo aptitude install -q -y postfix
