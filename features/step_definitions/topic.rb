# encoding: utf-8

Then /^it should display a topic creation form$/ do
  page.should have_css('form.new_topic')
  page.should have_css('input#topic_title')
  page.should have_css('textarea#topic_content')
end

Then /^it should display a topic edit form$/ do
  page.should have_css('form.edit_topic')
  page.should have_css('input#topic_title')
  page.should have_css('textarea#topic_content')
end

Then /^it should display a comment form$/ do
  page.should have_css('form.new_comment')
  page.should have_content('现在就添加一条回复')
end

Then /^it should not display a comment form$/ do
  page.should have_no_css('form.new_comment')
  page.should have_no_content('现在就添加一条回复')
end

Given /^the topic has comments of (\d+) pages \((\d+) per page\)$/ do |pages, per_page|
  topic = Topic.first
  Siteconf.pagination_comments = per_page.to_i
  (per_page.to_i * pages.to_i).times do
    FactoryGirl.create(:comment, :commentable => topic)
  end
end

Then /^it should display the pagination links$/ do
  within(".pagination") do
    page.should have_css('.first')
    page.should have_css('.active')
  end
end

Then /^it should display the mobile pagination links$/ do
  within(".pagination") do
    page.should have_css('.current')
    page.should have_css('.k_page')
  end
end

Then /^the current page is the last page$/ do
  last_child = find(".pagination .active span")
  last_child.tag_name.should == 'span'
end

Then /^the current mobile page is the last page$/ do
  last_child = find(".pagination .current")
  last_child.tag_name.should == 'span'
end

def str_to_num(str)
   case str
     when 'first'
       1
     when 'second'
       2
     when 'third'
       3
     end
end

When /^I click the (.*) page$/ do |page|
  within(".pagination") do
    click_link str_to_num(page).to_s
  end
end

Then /^the current page should be the (.*) page$/ do |page|
  find(".pagination .active span").text.should == str_to_num(page).to_s
end

Then /^the current mobile page should be the (.*) page$/ do |page|
  find(".pagination .current").text.should == str_to_num(page).to_s
end

Given /^a node exists with custom html: (.*)$/ do |html|
  FactoryGirl.create(:node, :custom_html => html)
end

Then /^it should display custom widget: (.*)$/ do |content|
  within("#Rightbar") do
    page.should have_content(content)
  end
end

Then /^it should display a mention button$/ do
  page.should have_css('img.mention_button')
end

When /^I click the mention button$/ do
  find("img.mention_button:first").click
end

Then /^the commenter user name should appear in the comment box$/ do
  mention_button = find("img.mention_button:first")
  find("#comment_content").value.should have_content(mention_button['data-mention'])
end

Then /^it should not display any mention buttons$/ do
  page.should have_no_css("img.mention_button")
end

When /^I post a comment with content: (.*)$/ do |content|
  fill_in "comment[content]", :with => content
  click_button '发送'
end

Given /^I have subscribed to the topic feed$/ do
  visit "/topics.atom"
end

Then /^it should display topic feeds$/ do
  doc = Nokogiri::XML(page.driver.response.body)
  doc.css('entry').size.should > 0
end
