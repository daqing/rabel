module Rabel
  class LinkEmailParser
    AUTO_LINK_RE = %r{
        (?: ((?:ed2k|ftp|http|https|irc|mailto|news|gopher|nntp|telnet|webcal|xmpp|callto|feed|svn|urn|aim|rsync|tag|ssh|sftp|rtsp|afs):)// | www\. )
        [^(\s|@|[\u4e00-\u9fa5]|[\uff00-\uffef]|[\u2e80-\u2eff]|[\u3000-\u303f]|[\u31c0-\u31ef])<]+
      }x

    # regexps for determining context, used high-volume
    AUTO_LINK_CRE = [/<[^>]+$/, /^[^>]*>/, /<a\b.*?>/i, /<\/a>/i]

    AUTO_EMAIL_RE = /[\w.!#\$%+-]+@[\w-]+(?:\.[\w-]+)+/

    BRACKETS = { ']' => '[', ')' => '(', '}' => '{' }

    WORD_PATTERN = RUBY_VERSION < '1.9' ? '\w' : '\p{Word}'

    # Turns all urls into clickable links.  If a block is given, each url
    # is yielded and the result is used as the link text.
    def self.parse_url(text)
      text.gsub(AUTO_LINK_RE) do
        scheme, href = $1, $&
        punctuation = []

        if auto_linked?($`, $')
          # do not change string; URL is already linked
          href
        else
          # don't include trailing punctuation character as part of the URL
          while href.sub!(/[^#{WORD_PATTERN}\/-]$/, '')
            punctuation.push $&
            if opening = BRACKETS[punctuation.last] and href.scan(opening).size > href.scan(punctuation.last).size
              href << punctuation.pop
              break
            end
          end
          
          href = 'http://' + href unless scheme
          result = block_given? ? yield(href) : href
          if result == href
            %(<a href="#{href}" target="_blank">#{href}</a>)
          else
            result
          end
        end
      end
    end
   

    # Turns all email addresses into clickable links.  If a block is given,
    # each email is yielded and the result is used as the link text.
    def self.parse_email(text)
      text.gsub(AUTO_EMAIL_RE) do
        text = $&
        new_text = (block_given?) ? yield(text) : text
        Rabel::Base.email_link(new_text)
      end
    end

    # Detects already linked context or position in the middle of a tag
    def self.auto_linked?(left, right)
      (left =~ AUTO_LINK_CRE[0] and right =~ AUTO_LINK_CRE[1]) or
        (left.rindex(AUTO_LINK_CRE[2]) and $' !~ AUTO_LINK_CRE[3])
    end
  end
end

