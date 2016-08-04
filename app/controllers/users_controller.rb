class UsersController < ApplicationController
  before_action :authenticate_user!, except: [:home]

  # To display users for subscribing
  def index
    @users = User.where.not(id: current_user.id)
  end

  # For subscribing to other users channels
  def subscribe_to_users
    user = User.find_by_id(current_user.id)
    user.subscribed_channel[:channel] << "channel_#{params[:user_id]}"
    user.save
    flash[:success] = 'User Subscribed'
    redirect_to request.referer || root_path
  end

end