# encoding: utf-8

Then /^it should display a compact topic creation form$/ do
  page.should have_css('form.new_topic')
  page.should have_css('input.sll')
  page.should have_css('textarea.mll')
end

Then /^it should not display a compact topic creation form$/ do
  page.should_not have_css('form.new_topic')
  page.should_not have_css('input.sll')
  page.should_not have_css('textarea.mll')
end

When /^I provide topic creation information$/ do
  fill_in "topic[title]", :with => 'hi'
  fill_in "topic[content]", :with => 'Rails is cool!'
  click_button '创建'
end

Given /^the node has topics of (\d+) pages$/ do |page_count|
  node = Node.first
  topic_count = Siteconf.pagination_topics.to_i * page_count.to_i
  topic_count.times do
    FactoryGirl.create(:topic, :node => node)
  end
end

Then /^it should display one page topics$/ do
  page.should have_css(".avatar", :count => Siteconf.pagination_topics.to_i)
end

Given /^a node exists with introduction: (.*)$/ do |intro|
  FactoryGirl.create(:node, :introduction => intro)
end

Then /^it should display the node form$/ do
  page.should have_css('form.node')
end

When /^I try to provide node info with name: (.*)$/ do |name|
  fill_in "node[key]", :with => 'node_key_1'
  fill_in "node[name]", :with => name
  click_button '保存'
end

