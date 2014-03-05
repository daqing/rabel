xml.instruct!
xml.urlset :"xmlns" => "http://www.sitemaps.org/schemas/sitemap/0.9" do
  if @lastmod.present?
    xml.url do
      xml.loc(root_url)
      xml.lastmod(@lastmod.strftime('%Y-%m-%d'))
      xml.changefreq('hourly')
      xml.priority('1.0')
    end
    @topics.each do |topic|
      xml.url do
        xml.loc(t_url(topic.id))
        if topic.comments_count > 0
          lastmod = topic.last_comment.updated_at
        else
          lastmod = topic.updated_at
        end
        xml.lastmod(lastmod.strftime('%Y-%m-%d'))
        xml.changefreq('daily')
        xml.priority('0.9')
      end
    end
    @pages.each do |page|
      xml.url do
        xml.loc(page_url(page.key))
        xml.lastmod(page.updated_at.strftime('%Y-%m-%d'))
        xml.changefreq('monthly')
        xml.priority('0.8')
      end
    end
  end
end

