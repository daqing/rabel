atom_feed :language => 'zh-CN' do |feed|
  feed.title Siteconf.site_name
  feed.updated @last_update

  @feed_items.each do |item|
    topic_url = t_url(item.id)
    feed.entry(item, :url => topic_url ) do |entry|
      entry.url topic_url
      entry.title item.title
      entry.content parse_markdown(item.content), :type => 'html'
      entry.updated item.updated_at.strftime("%Y-%m-%dT%H:%M:%SZ")

      entry.author do |author|
        author.name item.user.nickname
      end
    end
  end
end
