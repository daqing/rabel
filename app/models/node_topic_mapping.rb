class NodeTopicMapping < ActiveRecord::Base
  belongs_to :node
  belongs_to :topic
  # attr_accessible :title, :body
end
