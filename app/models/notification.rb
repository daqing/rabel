# encoding: utf-8
# == Schema Information
#
# Table name: notifications
#
#  id              :integer          not null, primary key
#  user_id         :integer
#  notifiable_type :string(255)
#  notifiable_id   :integer
#  content         :text
#  action_user_id  :integer
#  action          :string(255)
#  unread          :boolean          default(TRUE)
#  created_at      :datetime
#  updated_at      :datetime
#

class Notification < ActiveRecord::Base
  ACTION_MENTION = 'mention'
  ACTION_REPLY = 'reply'
  ACTION_TOPIC = 'topic'
  ACTION_REWARD = 'reward'

  belongs_to :user
  belongs_to :action_user, :class_name => 'User'
  belongs_to :notifiable, :polymorphic => true

  # Notify user
  def self.notify(user, notifiable, action_user, action, content)
    nf = Notification.new(:action => action, :content => content)
    nf.notifiable = notifiable
    nf.user = user
    nf.action_user = action_user
    nf.save
  end

  def action_info_prefix
    case self.action
    when ACTION_MENTION
      '在回复'
    when ACTION_REPLY
      '在'
    when ACTION_TOPIC
      '在话题'
    end
  end

  def action_info_suffix
    case self.action
    when ACTION_MENTION
      '时提到'
    when ACTION_REPLY
      '里回复'
    when ACTION_TOPIC
      '中提到'
    end
  end
end
