# send QUIT signal to old unicorn master
DIR=$( cd "$( dirname "$0" )" && pwd )
source $DIR/shared.sh

if [[ -f "./tmp/pids/unicorn.pid.oldbin" ]]; then
  oldpid=`cat ./tmp/pids/unicorn.pid.oldbin`
  log_info "send QUIT signal to pid=$oldpid"
  sudo kill -s QUIT $oldpid
else
  log_error "ERROR: unicorn master(old) not found."
fi

