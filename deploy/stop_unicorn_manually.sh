# send QUIT signal to unicorn master process
DIR=$( cd "$( dirname "$0" )" && pwd )
source $DIR/shared.sh

if [[ -f "./tmp/pids/unicorn.pid" ]]; then
  pid=`cat ./tmp/pids/unicorn.pid`
  log_info "send QUIT signal to pid=$pid"
  sudo kill -s QUIT $pid
else
  log_error "ERROR: unicorn master process not found"
fi

