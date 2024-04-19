module ApplicationHelper
  def append_notification_count(title)
    return title if @unread_count.zero?

    title + " (#{@unread_count})"
  end

  def build_navigation(items, _class_name = "gray")
    items.unshift(link_to(Siteconf.site_name, root_path, class: :rabel))
    items.join(' <span class="chevron">&nbsp;›&nbsp;</span> ').html_safe
  end

  def add_breadcrumb(item)
    @breadcrumbs << item
  end

  def build_breadcrumbs
    result_html =
      case @breadcrumbs.length
      when 1
        ""
      else
        @breadcrumbs.join("&nbsp;\u203A&nbsp;")
      end
    result_html.html_safe
  end

  def build_admin_navigation(items, class_name = "fade")
    items.unshift(link_to("\u7BA1\u7406\u540E\u53F0", admin_root_path))
    build_navigation(items, class_name)
  end

  def edit_topic_navigation(channel, topic)
    build_navigation([
                       link_to(channel.name, channel),
                       link_to(topic.title, t_path(topic.id)),
                       "\u7F16\u8F91"
                     ], "bigger")
  end

  def format_page(page_content)
    if Siteconf.allow_markdown_in_pages?
      parse_markdown(page_content)
    else
      format_content(page_content)
    end
  end

  def format_topic(topic_content)
    if Siteconf.allow_markdown_in_topics?
      parse_markdown(topic_content)
    else
      format_content(topic_content)
    end
  end

  def format_comment(comment_content)
    if Siteconf.allow_markdown_in_comments?
      parse_markdown(comment_content)
    else
      format_content(comment_content)
    end
  end

  def format_content(text)
    text = Rabel::LinkEmailParser.parse_url(Rabel::Base.h(text)) do |link|
      Rabel::Base.smart_url(link)
    end
    text = Rabel::LinkEmailParser.parse_email(text) do |address|
      Rabel::Base.protect_at_symbol(address)
    end

    nl_to_br(Rabel::Base.decode_symbols(Rabel::Base.make_mention_links(text))).html_safe
  rescue StandardError
    h(text)
  end

  def nl_to_br(text)
    text.gsub("\r\n", "<br/>").gsub("\r", "<br/>").gsub("\n", "<br/>")
  end

  def parse_markdown(text)
    nl_to_br(Rabel::Base.decode_symbols(
               Rabel::Base.make_mention_links(
                 MarkdownConverter.convert(text)
               )
             )).html_safe
  rescue Exception => e
    h(text)
  end

  def flash_messages
    @flash_messages ||= flash.select { |_type, message| message.length.positive? }
  end

  def show_flash_messages
    result = []
    flash_messages.each do |type, message|
      result << content_tag(:span, message, class: "#{type}-message")
    end
    result.join("<br/>").html_safe
  end

  def show_mobile_messages
    return unless flash_messages.any?

    content_tag(:div, show_flash_messages, class: :cell)
  end

  def search_engines
    {
      google: "http://www.google.com.hk/search?q=",
      bing: "http://cn.bing.com/search?q=",
      baidu: "http://www.baidu.com/s?wd="
    }
  end

  def search_engine_url
    search_engines[:bing]
  end

  def large_avatar(user)
    image_tag user.avatar.url, class: :large_avatar, alt: "#{user.nickname} large avatar"
  end

  def medium_avatar(user)
    image_tag user.avatar.url(:medium), class: :medium_avatar, alt: "#{user.nickname} medium avatar"
  end

  def mini_avatar(user)
    image_tag user.avatar.url(:mini), class: :mini_avatar, alt: "#{user.nickname} mini avatar"
  end

  def hash_key_append(hash, key, value)
    hash[key] = if hash[key].present?
                  "#{hash[key]} #{value}"
                else
                  value
                end
  end

  def nickname_profile_link(nickname, options = {})
    return "#" if nickname.blank?

    options[:title] = nickname
    hash_key_append(options, :class, "rabel profile_link")

    link_to nickname, member_path(nickname), options
  end

  def user_profile_link(user, options = {})
    nickname_profile_link(user.nickname, options)
  end

  def user_profile_avatar_link(user, avatar_size, options = {})
    avatar_method = "#{avatar_size}_avatar"

    options[:title] = user.nickname
    hash_key_append(options, :class, "profile_link")

    link_to(member_path(user.nickname), options) { send(avatar_method, user) }
  end

  def page_real_url(page)
    if page.content.start_with?("http")
      page.content
    elsif page.content.start_with?("/")
      page.content
    else
      page_path(page.key)
    end
  end

  def show_posting_device(comment)
    return unless comment.posting_device.present?

    content_tag(:span, "&nbsp;&nbsp;via #{comment.posting_device}".html_safe,
                class: :snow)
  end

  def auth_admin(error_tip = "tips.no_permission")
    redirect_to root_path, notice: t(error_tip) unless current_user.can_manage_site?
  end

  def cannonical_url(url)
    return "" if url.nil? || url.length.zero?

    url.start_with?("http://") ? url : "http://#{url}"
  end

  def weibo_icon_for(weibo_link)
    if weibo_link.include?("weibo.com")
      "sina_weibo"
    elsif weibo_link.include?("t.qq.com")
      "tx_weibo"
    else
      "twitter"
    end
  end

  def proper_length(str, len)
    if str.size > len
      "#{str[0..len]} ..."
    else
      str
    end
  end

  def link_to_active(title, path, current)
    if path == current
      link_to title, path, class: "active"
    else
      link_to title, path
    end
  end

  def rand_char
    ("a".."z").to_a.sample
  end

  def rand_avatar
    pic = ["1.jpg", "2.jpg", "3.png", "4.jpg", "5.png"].sample

    image_tag("/assets/avatar/#{pic}", width: 32, height: 32)
  end
end
