# send USR2 signal to unicorn master process
DIR=$( cd "$( dirname "$0" )" && pwd )
source $DIR/shared.sh

if [[ -f "./tmp/pids/unicorn.pid" ]]; then
  pid=`cat ./tmp/pids/unicorn.pid`
  log_info "send USR2 signal to pid=$pid"
  sudo kill -s USR2 $pid
  log_warning '!!! do NOT forget to kill the old unicorn process !!!'
else
  log_error "ERROR: unicorn master process not found"
fi

