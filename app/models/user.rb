# encoding:utf-8
require "carrierwave/orm/activerecord"

class User < ApplicationRecord
  has_secure_password

  mount_uploader :avatar, AvatarUploader

  validates :nickname, presence: true, uniqueness: true, length: { maximum: 12 }
  validate :nickname_cannot_contain_invalid_characters

  has_one :account, dependent: :destroy
  accepts_nested_attributes_for :account

  has_many :topics, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :bookmarks, dependent: :destroy
  has_many :notifications, dependent: :destroy
  has_many :rewards

  has_many :follower_relationships, class_name: "Following", foreign_key: "followed_user_id",
                                    dependent: :destroy
  has_many :followed_relationships, class_name: "Following", foreign_key: "user_id", dependent: :destroy

  has_many :followers, through: :follower_relationships
  has_many :followed_users, through: :followed_relationships

  has_many :checkins

  before_create :create_acount

  def latest_created_topics
    topics.order("created_at DESC").limit(10)
  end

  def latest_comments
    comments.order("created_at DESC").limit(10)
  end

  def bookmarked?(bookmarkable)
    bookmarkable.bookmarks.where(user_id: id).exists?
  end

  def bookmark_of(bookmarkable)
    bookmarkable.bookmarks.where(user_id: id).first
  end

  def bookmarked_nodes_count
    bookmarks.where(bookmarkable_type: "Node").count
  end

  def bookmarked_nodes
    ids = bookmarks.select(:bookmarkable_id).where(bookmarkable_type: "Node").collect(&:bookmarkable_id)
    Node.find(ids)
  end

  def bookmarked_topics_count
    bookmarks.where(bookmarkable_type: "Topic").count
  end

  def bookmarked_topics
    ids = bookmarks.select(:bookmarkable_id).where(bookmarkable_type: "Topic").collect(&:bookmarkable_id)
    Topic.find(ids)
  end

  def recent_followers
    follower_ids = follower_relationships.order("created_at DESC").limit(10).pluck(:user_id)
    follower_ids.map { |uid| User.find(uid) }
  end

  def follow(user)
    followed_users << user and true
  end

  def unfollow(user)
    user.followers.delete(self) and true
  end

  def following?(user)
    followed_relationships.where(followed_user_id: user.id).exists?
  end

  def followed_by?(user)
    follower_relationships.where(user_id: user.id).exists?
  end

  def follower_count
    @follower_count ||= follower_relationships.count
  end

  def followed_user_count
    @followed_user_count ||= followed_relationships.count
  end

  def follower_ids
    @follower_ids ||= follower_relationships.collect(&:user_id)
  end

  def followed_user_ids
    @followed_user_ids ||= followed_relationships.collect(&:followed_user_id)
  end

  def followed_topic_timeline
    # FIXME: cache this result
    Topic.where(user_id: followed_user_ids).order("created_at DESC").limit(10)
  end

  def root?
    id == 1 || role == "root"
  end

  def permission_role
    can_manage_site? ? :admin : :default
  end

  def admin?
    role == "admin"
  end

  def acts_as_admin
    self.role = "admin"
  end

  def acts_as_normal_user
    self.role = "user"
  end

  def can_manage_site?
    IsAdmin.call(self)
  end

  def unread_notification_count
    notifications.where(unread: true).count
  end

  def active_for_authentication?
    super && not_blocked?
  end

  def not_blocked?
    !blocked?
  end

  def inactive_message
    not_blocked? ? super : :blocked
  end

  def verify_captcha(correct_captcha)
    return true if captcha.downcase == correct_captcha.downcase

    errors.add(:captcha, "验证码不正确")
    false
  end

  def has_avatar?
    read_attribute(:avatar).present?
  end

  private

  def create_acount
    build_account if account.nil?
  end

  def nickname_cannot_contain_invalid_characters
    if nickname.present? && (nickname.include?("@") ||
                                    nickname.include?("-") ||
                                    nickname.include?(" ") ||
                                    nickname.include?(".") ||
                                    nickname.include?("/") ||
                                    nickname.include?("\\")
                            )
      errors.add(:nickname, "不能包含@, 横线, 斜线, 句点或空格")
    end
  end
end
