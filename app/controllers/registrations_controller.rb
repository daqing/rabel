class RegistrationsController
  def create; end

  private

  def user_params
    params.require(:user).permit(:email,
                                 :password,
                                 :password_confirmation,
                                 :nickname,
                                 :captcha)
  end
end
