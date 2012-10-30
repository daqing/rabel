rvmsudo thin install
[ ! -e /etc/rc.d/init.d/thin ] && sudo mv /etc/rc.d/thin /etc/rc.d/init.d/thin
sudo /sbin/chkconfig --level 345 thin on
rvm wrapper `rvm current` bootup thin
sudo su -c "sed -i -e '/DAEMON/ s|DAEMON=.*|DAEMON=$HOME/.rvm/bin/bootup_thin|' /etc/init.d/thin"
