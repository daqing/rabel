# shared library
log_error() {
  echo -e "\033[1;31m$1\033[0m"
}

log_info() {
  echo -e "\033[1;32m$1\033[0m"
}

log_warning() {
  echo -e "\033[1;41m$1\033[0m"
}

