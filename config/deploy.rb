# encoding: utf-8
# Add RVM's lib directory to the load path.
require "rvm/capistrano"

set :rvm_ruby_string, '1.9.3-p392'
set :rvm_type, :user

# http://gembundler.com/deploying.html
require 'bundler/capistrano'

# load 'deploy/assets'

# set this to keep from missing any password prompts
default_run_options[:pty] = true
set :ssh_options, { :forward_agent => true }

def prompt_with_default(var, default)
  set(var, Capistrano::CLI.ui.ask("#{var} [#{default}] : "))
  set(var, default) unless exists?(var) && fetch(var).length > 0
end

set :application, 'rabel'
set :scm, 'git'
set :scm_verbose, false

set :deploy_via, :remote_cache

set :unicorn_pid, "#{current_path}/tmp/pids/unicorn.pid"

prompt_with_default(:domain, 'rabelapp.com')
prompt_with_default(:deploy_to, "/srv/http/#{domain}")

prompt_with_default(:user, ENV['USER'])
set :use_sudo, false

set :rails_env, 'production'

set :repository, "git@github.com:daqing/#{application}.git"
prompt_with_default(:branch, 'master')

role :web, fetch(:domain)
role :app, fetch(:domain)
role :db, fetch(:domain), :primary => true

namespace :deploy do
  desc "启动服务"
  task :start, :roles => :app do
    run "cd #{current_path}; bundle exec unicorn -c ./config/unicorn.rb -E production -D"
  end

  desc "停止服务"
  task :stop, :roles => :app do
    run "kill `cat #{unicorn_pid}`"
  end

  desc "重新加载服务"
  task :reload, :roles => :app do
    run "kill -s USR2 `cat #{unicorn_pid}`"
  end

  desc "重新启动服务"
  task :restart, :roles => :app do
    stop
    start
  end

  desc '收拾房间，链接文件'
  task :housekeeping, :roles => :app do
    run "rm -f #{current_path}/config/initializers/siteconf.rb"
    run "ln -s #{shared_path}/config/siteconf.rb #{current_path}/config/initializers/siteconf.rb"

    run "rm -f #{current_path}/config/database.yml"
    run "ln -s #{shared_path}/config/database.yml #{current_path}/config/database.yml"

    run "rm -rf #{current_path}/config/settings.yml"
    run "ln -s #{shared_path}/config/settings.yml #{current_path}/config/settings.yml"

    run "rm -rf #{current_path}/public/uploads"
    run "ln -s #{shared_path}/uploads #{current_path}/public/uploads"

    run "cd #{current_path}; RAILS_ENV=#{rails_env} bundle exec rake assets:clean"
    run "cd #{current_path}; RAILS_ENV=#{rails_env} bundle exec rake assets:precompile"
  end
end

after 'deploy:create_symlink', 'deploy:housekeeping', 'deploy:migrate'
after 'deploy', 'deploy:cleanup'