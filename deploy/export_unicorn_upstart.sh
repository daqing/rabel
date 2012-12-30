if [ -z "$1" -o -z "$2" -o -z "$3" ]; then
  echo -e "\033[1;31mUSAGE: $0 [upstart_path] [username] [app_name]\033[0m"
  echo -e "\033[1;32m--- example ---"
  echo -e "$0 /etc/init rabel rabelapp\033[0m"
  exit
fi

rvmsudo bundle exec foreman export upstart "$1" -u "$2" -a "$3"
