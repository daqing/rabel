# encoding: utf-8

# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

def create_seeds_data
  password = 'project-rabel'
  user = User.create(:nickname => 'root', :email => 'root@rabelapp.com', :password => password, :password_confirmation => password)

  Page.create(:key => 'about', :title => '关于我们', :content => '这是一个用rabel搭建的现代社区')
end

create_seeds_data unless Rails.env.production?

