class Bookmark < ApplicationRecord
  belongs_to :user
  belongs_to :bookmarkable, :polymorphic => true
end
