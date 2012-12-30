if [ -z "$1" ]; then
  echo -e "\033[1;31mUSAGE: $0 [pid] \033[0m"
  echo -e "\033[1;32m--- example ---"
  echo -e "$0 9527 \033[0m"
  exit
fi

sudo kill -QUIT "$1"
