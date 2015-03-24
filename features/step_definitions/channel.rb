# encoding: utf-8

Given /^the channel has topics of (\d+) pages$/ do |page_count|
  channel = Channel.first
  topic_count = Siteconf.pagination_topics.to_i * page_count.to_i
  topic_count.times do
    FactoryGirl.create(:topic, :channel => channel)
  end
end

Then /^it should display one page topics$/ do
  page.should have_css(".avatar", :count => Siteconf.pagination_topics.to_i)
end

Given(/^a channel exists with name:(.*)$/) do |name|
  @channel = FactoryGirl.create(:channel, :name => name)
end

Given(/^a topic under the channel exists with title: (.*)$/) do |title|
  @topic = FactoryGirl.create(:topic, channel: @channel, title: title)
end
