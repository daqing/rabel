# encoding: utf-8

require 'cgi'

module Rabel
  module Base
    def self.make_mention_links(text)
      text.gsub(Notifiable::MENTION_REGEXP) do
        if $1.present?
          %(@<a class="rabel" href="/member/#{$1}">#{$1}</a>)
        else
          "@#{$1}"
        end
      end
    end

    def self.h(text)
      CGI.escapeHTML(text)
    end

    def self.smart_url(link)
      if link =~ /http:\/\/v.youku.com\/v_show\/id_(.*)\.html/
        self.embed_video("http://player.youku.com/player.php/sid/#{$1}/v.swf")
      elsif link =~ /http:\/\/www.tudou.com\/programs\/view\/([a-zA-Z0-9\-_]+)\/?/
        self.embed_video("http://www.tudou.com/v/#{$1}/v.swf")
      elsif link =~ /xiami\.com\/widget\/?(.*)\/albumPlayer/
        embed_music(link, 235, 346)
      elsif link =~ /xiami\.com\/widget\/?(.*)\/singlePlayer/
        embed_music(link, 257, 33)
      elsif link =~ /\.(jpg|jpeg|png|gif)$/i
        self.show_image(link)
      else
        self.external_link(link, link)
      end
    end

    def self.protect_at_symbol(text)
      begin
        text.gsub("@", "%AT%")
      rescue
        text
      end
    end

    def self.decode_symbols(text)
      text.gsub("%AT%", "@").gsub("%N%", "<br/>")
    end

    def self.email_link(address)
      %(<a href="mailto:#{address}" class="external mail">#{address}</a>)
    end

    def self.external_link(content, url)
      %(<a href="#{url}" class="external" target="_blank" rel="nofollow">#{content}</a>)
    end

    def self.show_image(url)
      %(<img src="#{url}" class="external" />)
    end

    def self.embed_video(url)
      %(<embed src="#{url}" type="application/x-shockwave-flash" allowscriptaccess="always" allowfullscreen="false" wmode="opaque" width="480" height="400" quality="high" align="middle"></embed>)
    end

    def self.embed_music(url, width, height)
      %(<embed src="#{url}" type="application/x-shockwave-flash" wmode="transparent" width="#{width}" height="#{height}" align="middle"></embed>)
    end
  end
end

