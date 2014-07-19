class Bookmark < ActiveRecord::Base
  validates :user_id, :bookmarkable_type, :bookmarkable_id, :presence => true

  belongs_to :user
  belongs_to :bookmarkable, :polymorphic => true
end
