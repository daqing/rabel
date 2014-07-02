# encoding: utf-8
# == Schema Information
#
# Table name: pages
#
#  id         :integer          not null, primary key
#  key        :string(255)
#  title      :string(255)
#  content    :text
#  created_at :datetime
#  updated_at :datetime
#  published  :boolean          default(FALSE)
#  position   :integer
#

class Page < ActiveRecord::Base
  include Sortable
  include Rabel::ActiveCache

  acts_as_list

  validates :key, :title, :content, :presence => true

  def self.only_published
    where(:published => true)
  end
end
