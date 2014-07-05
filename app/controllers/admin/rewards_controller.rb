# encoding: utf-8
class Admin::RewardsController < Admin::BaseController
  before_filter :find_parent_user, :except => [:index]

  def index
    @rewards = Reward.order('created_at DESC').page(params[:page])
    @title = '奖励记录'
  end

  def new
    respond_to do |f|
      f.js {
        @reward_type = params[:reward_type].present? ? params[:reward_type] : Reward::TYPE_GRANT
        @reward = @user.rewards.build(:reward_type => @reward_type, :amount_str => '0')
      }
    end
  end

  def create
    respond_to do |f|
      f.js {
        @reward = @user.rewards.build(params[:reward])
        @reward_type = @reward.reward_type
        @reward.admin_user = current_user

        result = Reward.transaction do
          @reward.save && @user.update_attributes({:reward => @user.reward + @reward.amount}, :as => current_user.permission_role)
        end

        render :new and return unless result
      }
    end
  end
end
