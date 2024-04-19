class SessionsController < ApplicationController
  def new; end

  def create
    @user = User.find_by(nickname: params[:session][:nickname].strip)

    if @user&.authenticate(params[:session][:password])
      sign_in(@user)

      redirect_to root_path
    else
      respond_to(&:turbo_stream)
    end
  end

  def destroy
    sign_out

    redirect_to root_path
  end
end
