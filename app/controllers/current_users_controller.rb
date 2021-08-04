class CurrentUsersController < ApplicationController
  def me
    render json: current_user
  end
end
