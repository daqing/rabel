class Bookmark < ActiveRecord::Base
  validates :user_id, :bookmarkable_type, :bookmarkable_id, :presence => true
  attr_protected :user_id, :bookmarkable_type, :bookmarkable_id

  belongs_to :user
  belongs_to :bookmarkable, :polymorphic => true
end
