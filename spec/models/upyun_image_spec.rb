# == Schema Information
#
# Table name: upyun_images
#
#  id           :integer          not null, primary key
#  asset        :string(255)
#  created_at   :datetime
#  updated_at   :datetime
#  user_id      :integer
#  size         :integer
#  filename     :string(255)
#  content_type :string(255)
#

require 'spec_helper'

describe UpyunImage do
end
