# start unicorn master process manually
DIR=$( cd "$( dirname "$0" )" && pwd )
source $DIR/shared.sh

bundle exec unicorn -c `pwd`/config/unicorn.rb -E production -D

if [[ "$?" == 0 ]]; then
  log_info "unicorn master started."
else
  log_error "master failed to start."
  tail -n 60 ./log/unicorn.stderr.log | less
fi

