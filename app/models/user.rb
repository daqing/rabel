# encoding:utf-8
require 'carrierwave/orm/activerecord'

class User < ActiveRecord::Base
  include Rabel::ActiveCache
  # Include default devise modules. Others available are:
  # :token_authenticatable, :encryptable, :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  # Setup accessible (or protected) attributes for your model
  attr_accessor :captcha

  BASE_FIELDS = [:nickname, :email, :password, :password_confirmation,
    :remember_me, :avatar, :account_attributes, :captcha
  ]

  attr_accessible *BASE_FIELDS
  attr_accessible *(BASE_FIELDS + [:reward]), :as => :admin

  mount_uploader :avatar, AvatarUploader

  validates :nickname, :presence => true, :uniqueness => true, :length => {:maximum => 12}
  validate :nickname_cannot_contain_invalid_characters

  has_one :account, :dependent => :destroy
  accepts_nested_attributes_for :account

  has_many :topics, :dependent => :destroy
  has_many :comments, :dependent => :destroy
  has_many :bookmarks, :dependent => :destroy
  has_many :notifications, :dependent => :destroy
  has_many :rewards

  has_many :follower_relationships, :class_name => 'Following', :foreign_key => 'followed_user_id', :dependent => :destroy
  has_many :followed_relationships, :class_name => 'Following', :foreign_key => 'user_id', :dependent => :destroy

  has_many :followers, :through => :follower_relationships
  has_many :followed_users, :through => :followed_relationships

  before_create :create_acount

  def latest_created_topics
    self.topics.order('created_at DESC').limit(10)
  end

  def latest_comments
    self.comments.order('created_at DESC').limit(10)
  end

  def bookmarked?(bookmarkable)
    bookmarkable.bookmarks.where(:user_id => self.id).exists?
  end

  def bookmark_of(bookmarkable)
    bookmarkable.bookmarks.where(:user_id => self.id).first
  end

  def bookmarked_nodes_count
    self.bookmarks.where(:bookmarkable_type => 'Node').count
  end

  def bookmarked_nodes
    ids = self.bookmarks.select(:bookmarkable_id).where(:bookmarkable_type => 'Node').collect(&:bookmarkable_id)
    Node.find(ids)
  end

  def bookmarked_topics_count
    self.bookmarks.where(:bookmarkable_type => 'Topic').count
  end

  def bookmarked_topics
    ids = self.bookmarks.select(:bookmarkable_id).where(:bookmarkable_type => 'Topic').collect(&:bookmarkable_id)
    Topic.find(ids)
  end

  def recent_followers
    follower_ids = self.follower_relationships.order('created_at DESC').limit(10).pluck(:user_id)
    follower_ids.map { |uid| User.find_cached(uid) }
  end

  def follow(user)
    self.followed_users << user and true
  end

  def unfollow(user)
    user.followers.delete(self) and true
  end

  def following?(user)
    self.followed_relationships.where(:followed_user_id => user.id).exists?
  end

  def followed_by?(user)
    self.follower_relationships.where(:user_id => user.id).exists?
  end

  def follower_count
    @follower_count ||= self.follower_relationships.count
  end

  def followed_user_count
    @followed_user_count ||= self.followed_relationships.count
  end

  def follower_ids
    @follower_ids ||= self.follower_relationships.collect(&:user_id)
  end

  def followed_user_ids
    @followed_user_ids ||= self.followed_relationships.collect(&:followed_user_id)
  end

  def followed_topic_timeline
    # FIXME: cache this result
    Topic.where(:user_id => self.followed_user_ids).order('created_at DESC').limit(10)
  end

  def root?
    self.id == 1 || self.role == 'root'
  end

  def permission_role
    can_manage_site? ? :admin : :default
  end

  def admin?
    self.role == 'admin'
  end

  def acts_as_admin
    self.role = 'admin'
  end

  def acts_as_normal_user
    self.role = 'user'
  end

  def can_manage_site?
    root? || admin?
  end

  def unread_notification_count
    self.notifications.where(:unread => true).count
  end

  def active_for_authentication?
    super && not_blocked?
  end

  def not_blocked?
    not self.blocked?
  end

  def inactive_message
    not_blocked? ? super : :blocked
  end

  def verify_captcha(correct_captcha)
    return true unless Siteconf.show_captcha?
    if self.captcha.downcase == correct_captcha.downcase
      true
    else
      self.errors.add(:captcha, "验证码不正确")
      false
    end
  end

  def has_avatar?
    self.read_attribute(:avatar).present?
  end

  private
    def create_acount
      self.build_account if self.account.nil?
    end

    def nickname_cannot_contain_invalid_characters
      if self.nickname.present? and (self.nickname.include?('@') or
                                     self.nickname.include?('-') or
                                     self.nickname.include?(' ') or
                                     self.nickname.include?('.') or
                                     self.nickname.include?('/') or
                                     self.nickname.include?('\\')
                                    )
        errors.add(:nickname, "不能包含@, 横线, 斜线, 句点或空格")
      end
    end
end

