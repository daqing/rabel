# == Schema Information
#
# Table name: followings
#
#  id               :integer          not null, primary key
#  user_id          :integer
#  followed_user_id :integer
#  created_at       :datetime
#  updated_at       :datetime
#

# FIXME
# Three indexes were added: :user_id, :followed_user_id and [:user_id, :followed_user_id]
# Need to know if all indexes are needed
class Following < ActiveRecord::Base

  belongs_to :follower, :class_name => 'User', :foreign_key => 'user_id'
  belongs_to :followed_user, :class_name => 'User'
end
