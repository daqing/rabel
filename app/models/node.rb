# encoding: utf-8
class Node < ActiveRecord::Base
  include Sortable
  include Rabel::ActiveCache

  has_many :node_topic_mappings, :dependent => :destroy
  has_many :topics, :through => :node_topic_mappings

  has_many :bookmarks, :as => :bookmarkable, :dependent => :destroy

  validates :name, :key, :presence => true
  validates :key, :uniqueness => true, :format => {:with => /[a-zA-Z0-9_-]+/, :message => I18n.t('tips.node_key_format')}
  validate :node_key_should_not_contain_slash

  attr_accessible :name, :key, :custom_css, :custom_html, :introduction, :position, :quiet

  def can_delete?
    self.topics.count == 0
  end

  private
    def node_key_should_not_contain_slash
      errors.add(:key, "不能包含斜线(/)") if self.key.present? and self.key.include?('/')
    end
end
