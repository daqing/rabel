# == Schema Information
#
# Table name: topics
#
#  id              :integer          not null, primary key
#  node_id         :integer
#  user_id         :integer
#  title           :string(255)
#  content         :text
#  hit             :integer
#  created_at      :datetime
#  updated_at      :datetime
#  involved_at     :datetime
#  comments_count  :integer          default(0), not null
#  comments_closed :boolean          default(FALSE), not null
#  sticky          :boolean          default(FALSE)
#  last_replied_by :string(255)      default("")
#  last_replied_at :datetime
#

# Read about factories at http://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :topic do
    user
    node
    title 'Hello'
    content 'Hello, world'
    comments_closed false
    sticky false

    factory :locked_topic do
      created_at Time.now - Siteconf.topic_editable_period
    end

    factory :closed_topic do
      comments_closed true
    end
  end
end
