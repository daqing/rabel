# encoding: utf-8
class Settings < Settingslogic
  source "#{Rails.root}/config/settings.yml"
  namespace Rails.env

  def self.themes
    {:pb2 => '默认'}
  end

  def self.topic_list_styles
    {:simple => '极简', :complex => '丰富'}
  end
end
