xml.instruct!
xml.urlset do
  @topics.each do |topic|
    xml.url do
      xml.loc(t_url(topic.id))
      if topic.comments_count > 0
        lastmod = topic.last_comment.updated_at
      else
        lastmod = topic.updated_at
      end
      xml.lastmod(lastmod.strftime('%Y-%m-%d'))
      xml.changefreq('hourly')
      xml.priority('1.0')
    end
  end
end

