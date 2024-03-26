class CheckinsController < ApplicationController
  before_action :authenticate_user!

  def create
    CheckIn.new(current_user).perform

    redirect_to root_path
  end
end
