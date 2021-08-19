class CurrentUsersController < ApplicationController
  before_action :authenticate_user!
  def me
    render json: current_user
  end
end
