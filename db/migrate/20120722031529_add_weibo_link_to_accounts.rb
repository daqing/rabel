class AddWeiboLinkToAccounts < ActiveRecord::Migration
  def up
    add_column :accounts, :weibo_link, :string, default: ''
    User.find_each do |user|
      user.account.update_column(:weibo_link, "http://twitter.com/#{user.account.twitter_id}") if user.account.twitter_id.present?
    end
    remove_column :accounts, :twitter_id
  end

  def down
    add_column :accounts, :twitter_id
    remove_column :accounts, :weibo_link
  end
end
