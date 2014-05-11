require 'rubygems'
require 'yaml'

envs = YAML.load_file('./config/application.yml')
kv = envs.map {|k, v| "#{k}=\"#{v}\""}
`heroku config:add #{kv.join(' ')}`
