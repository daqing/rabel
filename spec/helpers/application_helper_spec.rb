# encoding: utf-8
require 'spec_helper'

describe ApplicationHelper do
  describe "markdown parsing" do
    it "should not double escape HTML" do
      helper.parse_markdown(%(`"nginx"`)).should == "<p><code>&quot;nginx&quot;</code></p>"
      helper.parse_markdown(%(foo & bar)).should == "<p>foo &amp; bar</p>"
    end

    it "should escape html" do
      helper.parse_markdown("<script>").should == "<p>&lt;script&gt;</p>"
    end

    it "should convert newlines" do
      helper.parse_markdown("foo\nbar").should == '<p>foo<br/>bar</p>'
      helper.parse_markdown("foo\rbar").should == '<p>foo<br/>bar</p>'
      helper.parse_markdown("foo\rbar").html_safe?.should be_true
    end

    it "should protect email address" do
      helper.parse_markdown('foo@bar.com').include?('foo@bar.com').should be_true
    end

    it "should not throw exceptions in bad code" do
      helper.parse_markdown('~~~~code~').should == '~~~~code~'
      helper.parse_markdown('~~~~code~<script>').should == '~~~~code~&lt;script&gt;'
    end

    it "should foramt content" do
      helper.format_content("\r\nfoobar").should == '<br/>foobar'
      helper.format_content('foobar@example.org').include?('mailto').should be_true
      helper.format_content('www.g.cn').include?('http').should be_true
      helper.format_content('@daqing').include?('/member/').should be_true
    end

    it "should not raise exception" do
      expect {
        helper.format_comment("http://rabelapp.com访问")
        helper.format_comment("http://rabelapp.com，")
      }.to_not raise_error
    end
  end

  describe "markdown support in comments" do
    it "when closed" do
      Siteconf.allow_markdown_in_comments = 'off'
      helper.format_comment('*foobar*').should == '*foobar*'
      helper.format_comment('**<script>**').should == '**&lt;script&gt;**'
      helper.format_comment("hello\nworld").should == 'hello<br/>world'
    end

    it "when open" do
      Siteconf.allow_markdown_in_comments = 'on'
      helper.format_comment('*foobar*').should == '<p><em>foobar</em></p>'
      helper.format_comment("foo\rbar").should == '<p>foo<br/>bar</p>'
    end
  end
end
