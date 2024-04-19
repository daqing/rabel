class RegistrationsController < ApplicationController
  def create
    @user = User.new(user_params)

    if @user.save
      sign_in(@user)

      redirect_to root_path
    else
      respond_to do |format| # rubocop:disable Style/SymbolProc
        format.turbo_stream
      end
    end
  end

  private

  def user_params
    params.require(:sign_up).permit(:nickname, :password)
  end
end
