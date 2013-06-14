DIR=$( cd "$( dirname "$0" )" && pwd )
source $DIR/shared.sh

if [ -z "$1" -o -z "$2" ]; then
  log_error "USAGE: $0 [mysql_password] [domain]"
  log_info "--- example ---"
  log_info "$0 e17c92a rabelapp.com"
  exit
fi

MYSQL_PASSWD="$1"
MAIL_DOMAIN="$2"

# Enable EPEL
sudo su -c 'rpm -Uvh http://download.fedoraproject.org/pub/epel/6/i386/epel-release-6-8.noarch.rpm'
sudo yum update -y
sudo yum install -y unzip curl wget vim

# Install deps
sudo yum install -y gcc-c++ patch readline readline-devel zlib zlib-devel \
libyaml-devel libffi-devel openssl-devel make bzip2 autoconf automake \
libtool bison gsfonts iconv-devel git \
mysql-libs mysql-devel ImageMagick-devel

# Install RVM
curl -L https://get.rvm.io | bash -s stable
source ~/.rvm/scripts/rvm
rvm install 1.9.3-p327
rvm use 1.9.3-p327 --default

sudo yum install -y postfix ImageMagick ImageMagick-perl nginx memcached

# Install MySQL Server
sudo yum install -y mysql-server
sudo /etc/init.d/mysqld restart

# Set MySQL root password
/usr/bin/mysqladmin -u root password "$MYSQL_PASSWD"

# Set mail domain for postfix
sudo su -c "sed -i -e '/^#mydomain/a mydomain = $MAIL_DOMAIN' /etc/postfix/main.cf"
