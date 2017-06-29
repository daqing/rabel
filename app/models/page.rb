# encoding: utf-8
class Page < ApplicationRecord
  include Sortable

  acts_as_list

  validates :key, :title, :content, :presence => true

  def self.only_published
    where(:published => true)
  end
end
