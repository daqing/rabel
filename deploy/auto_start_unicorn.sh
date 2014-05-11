# create unicorn upstart script for this website
DIR=$( cd "$( dirname "$0" )" && pwd )
source $DIR/shared.sh

if [[ -z "$1" || -z "$2" ]]; then
  log_error "USAGE: $0 [site_name] [/path/to/app/home]"
  log_info "--- example ---"
  log_info "$0 rabelapp /home/rabel/sites/rabelapp"
  exit 1;
fi

site_name="$1"
app_home="$2"
tmp_file="$app_home/tmp/$site_name.conf"

# create rvm wrapper
if [[ ! -f "$HOME/.rvm/bin/bootup_unicorn" ]]; then
  rvm wrapper `rvm current` bootup unicorn
fi

cat > $tmp_file <<EOF
author "Devin Zhang <daqing1986@gmail.com>"
description "$site_name running on Nginx/Unicorn"

start on runlevel [2]
stop on runlevel [016]

kill signal QUIT

respawn
respawn limit 3 10

exec $HOME/.rvm/bin/bootup_unicorn -c $app_home/config/unicorn.rb -E production

respawn
EOF

sudo mv $tmp_file /etc/init/
log_info "done"
