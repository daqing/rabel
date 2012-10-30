if [ -n "$1" ]; then
  sudo mkdir /etc/thin
  thin config -C ~/$1.yml -s1 -e production -p 3000 -a 127.0.0.1
  sudo mv ~/$1.yml /etc/thin
else
  echo -e "\033[1;31mUSAGE: $0 [name] \033[0m"
  echo -e "\033[1;32m--- example ---"
  echo -e "$0 rabelapp \033[0m"
fi
