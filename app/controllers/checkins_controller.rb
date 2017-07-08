class CheckinsController < ApplicationController
  before_action :authenticate_user!

  def create
    CheckIn.with(current_user)
    redirect_to root_path
  end
end
