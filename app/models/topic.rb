class Topic < ActiveRecord::Base
  include Notifiable
  include Rabel::ActiveCache

  DEFAULT_HIT = 0
  default_value_for :hit, DEFAULT_HIT
  default_value_for :content, ''
  default_value_for :involved_at do
    Time.zone.now
  end

  belongs_to :node, :touch => true, :counter_cache => true
  belongs_to :user
  has_many :comments, :as => :commentable, :dependent => :destroy
  has_many :bookmarks, :as => :bookmarkable, :dependent => :destroy
  has_many :notifications, :as => :notifiable, :dependent => :destroy

  validates :node_id, :user_id, :title, :presence => true

  attr_accessible :title, :content
  attr_accessible :title, :content, :comments_closed, :sticky, :as => :admin

  after_create :send_notifications

  def last_comment
    self.comments.order('created_at ASC').last
  end

  def locked?
    Time.now - self.created_at > Siteconf.topic_editable_period
  end

  def allow_modification_by?(user)
    (!locked? && self.user == user) || user.can_manage_site?
  end

  def notifiable_title
    title
  end

  def notifiable_path
    "/t/#{id}"
  end

  def self.sticky_topics
    ts = select('updated_at').with_sticky(true).order('updated_at DESC').first.try(:updated_at)
    return Rabel::Model::EMPTY_DATASET unless ts.present?
    count = with_sticky(true).count
    Rails.cache.fetch("topics/sticky/#{ts}-#{count}") do
      with_sticky(true).order('updated_at DESC').all
    end
  end

  def self.home_topics(num)
    ts = select('updated_at').order('updated_at DESC').first.try(:updated_at)
    return Rabel::Model::EMPTY_DATASET unless ts.present?
    node_ts = Node.select('updated_at').order('updated_at DESC').first.try(:updated_at)
    Rails.cache.fetch("topics/homepage/#{self.count}/#{num}-#{ts}/#{node_ts}") do
      excluded_nodes = Node.where(:quiet => true).pluck(:id)
      if excluded_nodes.any?
        where("node_id NOT in (?)", excluded_nodes).with_sticky(false).latest_involved_topics(num)
      else
        with_sticky(false).latest_involved_topics(num)
      end
    end
  end

  def self.with_sticky(sticky)
    where(:sticky => sticky)
  end

  def self.latest_involved_topics(num)
    order('involved_at DESC').limit(num).all
  end

  def self.recent_topics(num)
    ts = select('updated_at').order('updated_at DESC').first.try(:updated_at)
    return Rabel::Model::EMPTY_DATASET unless ts.present?
    Rails.cache.fetch("topics/recent/#{self.count}/#{num}-#{ts}") do
      order('involved_at DESC').limit(num).all
    end
  end

  def mention_check_text
    self.title + self.content
  end

  def mentioned_users
    mentioned_names = self.mention_check_text.scan(Notifiable::MENTION_REGEXP).collect {|matched| matched.first}.uniq
    mentioned_names.delete(self.user.nickname)
    mentioned_names.map { |name| User.find_by_nickname(name) }.compact
  end

  def prev_topic(node)
    node.topics.where(['id < ?', self.id]).order('created_at DESC').first
  end

  def next_topic(node)
    node.topics.where(['id > ?', self.id]).order('created_at ASC').first
  end

  private

    def send_notifications
      mentioned_users.each do |user|
        Notification.notify(
          user,
          self,
          self.user,
          Notification::ACTION_TOPIC,
          self.content
        )
      end
    end

end
