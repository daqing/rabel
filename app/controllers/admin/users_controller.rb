# encoding: utf-8
class Admin::UsersController < Admin::BaseController
  before_filter :find_user, :only => [:edit, :update, :toggle_admin, :toggle_blocked, :destroy]

  def index
    if params[:nickname].present?
      @user = User.find_by_nickname(params[:nickname])
      if @user.present?
        @users = [@user]
      else
        @users = []
      end
      @users = Kaminari.paginate_array(@users).page(params[:page])
    else
      @users = User.order('created_at DESC, id DESC').page(params[:page])
    end
    @title = '用户'
  end

  def edit
    authorize! :edit_info, @user

    @title = '修改用户信息'
  end

  def update
    authorize! :edit_info, @user

    if params[:user][:password].empty?
      params[:user].delete(:password)
      params[:user].delete(:password_confirmation)
    end

    if @user.update_attributes(params[:user], :as => current_user.permission_role)
      redirect_to admin_users_path + "?nickname=#{@user.nickname}"
    else
      render :edit
    end
  end

  def toggle_admin
    respond_to do |format|
      if current_user.can_manage_site?
        if @user.admin?
          @user.acts_as_normal_user
        else
          @user.acts_as_admin
        end
        if @user.save
          format.js
        else
          format.js { render :json => {:error => 'toggle admin failed'}, :status => :unprocessable_entity }
        end
      else
        format.js { render :json => {:error => 'no permission'}, :status => :forbidden }
      end
    end
  end

  def toggle_blocked
    respond_to do |format|
      if current_user.can_manage_site?
        if @user.toggle!(:blocked)
          format.js
        else
          format.js { render :json => {:error => 'toggle admin failed'}, :status => :unprocessable_entity }
        end
      else
        format.js { render :json => {:error => 'no permission'}, :status => :forbidden }
      end
    end
  end

  def destroy
    if @user.destroy
      flash[:success] = "会员 #{@user.nickname} 删除成功。"
      redirect_to root_path
    else
      flash[:error] = "会员 #{@user.nickname} 删除失败。"
      redirect_to member_path(@user.nickname)
    end
  end

  private
    def find_user
      @user = User.find(params[:id])
    end
end
