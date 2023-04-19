# encoding: utf-8
class UsersController < ApplicationController
  before_action :authenticate_user!, except: %i[show topics]

  layout 'single-column'

  def show
    @user = User.where(nickname: params[:nickname]).first
    store_location

    @title = "#{@user.nickname} - #{Siteconf.site_name}"

    @signature = @user.account.try(:signature) || ''
    @weibo_link = cannonical_url(@user.account.try(:weibo_link)) || ''
    @personal_website = cannonical_url(@user.account.try(:personal_website)) || ''
    @location = @user.account.try(:location) || ''
    @introduction = @user.account.try(:introduction) || ''

    @nickname_tip = (@user == current_user) ? '我' : @user.nickname
  end

  def topics
    @user = User.where(nickname: params[:nickname]).first

    @current_page = params[:page].present? ? params[:page] : 1
    @topics = @user.topics.page(@current_page).per(20).order('created_at DESC')

    @title = "#{@user.nickname} 创建的所有主题 - #{Siteconf.site_name}"
  end

  def edit
    @user = current_user
    @user.build_account unless @user.account.present?
    @title = '设置'

    respond_to do |format|
      format.html
    end
  end

  def update_account
    @user = current_user
    if @user.update_without_password(user_params)
      flash[:success] = '个人设置成功更新'
      sign_in :user, current_user, bypass: true
      redirect_to settings_path
    else
      flash[:error] = '个人设置保存失败'
      render :edit
    end
  end

  def update_password
    @user = current_user
    if @user.update_with_password(user_params)
      flash[:success] = '密码已成功更新，下次请用新密码登录'
      sign_in :user, current_user, bypass: true
      redirect_to settings_path
    else
      flash[:error] = '密码更新失败'
      render :edit
    end
  end

  def update_avatar
    @user = current_user
    if params[:user].present?
      if @user.update_without_password(user_params)
        flash[:success] = '头像更新成功'
        redirect_to settings_path + '#avatar'
      else
        flash[:error] = '头像更新失败'
        render :edit
      end
    else
      redirect_to settings_path + '#avatar', notice: '请选择要上传的头像'
    end
  end

  def my_topics
    @my_topics = current_user.bookmarked_topics
    @title = '我收藏的话题'
  end

  def my_following
    @my_followed_users = current_user.followed_users
    @followed_topic_timeline = current_user.followed_topic_timeline
    @title = '我的特别关注'
  end

  def follow
    @followed_user = User.find_by_nickname!(params[:nickname])
    unless current_user.following?(@followed_user)
      flash[:error] = '加入特别关注失败' unless current_user.follow(@followed_user)
    end
    redirect_to member_path(params[:nickname])
  end

  def unfollow
    @followed_user = User.find_by_nickname!(params[:nickname])
    if current_user.following?(@followed_user)
      flash[:error] = '取消特别关注失败' unless current_user.unfollow(@followed_user)
    end
    redirect_to member_path(params[:nickname])
  end

  private

  def user_params
    params.require(:user).permit(:avatar,
                                 :password,
                                 :password_confirmation,
                                 :current_password,
                                 :email,
                                  account_attributes: %i[personal_website location weibo_link introduction signature])
  end
end
