rvmsudo thin install
sudo /usr/sbin/update-rc.d -f thin defaults
rvm wrapper `rvm current` bootup thin
sudo su -c "sed -i -e '/DAEMON/ s|DAEMON=.*|DAEMON=$HOME/.rvm/bin/bootup_thin|' /etc/init.d/thin"
