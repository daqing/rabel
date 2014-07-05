# encoding: utf-8
class Page < ActiveRecord::Base
  include Sortable
  include Rabel::ActiveCache

  acts_as_list

  validates :key, :title, :content, :presence => true
  attr_accessible :key, :title, :content, :published, :position

  def self.only_published
    where(:published => true)
  end
end
