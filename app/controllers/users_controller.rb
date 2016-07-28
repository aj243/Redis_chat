class UsersController < ApplicationController
	before_action :authenticate_user!, except: [:home]

	def subscribe_to_users
		user = User.find_by_id(current_user.id)
		if user.subscribed_channel.nil?
			user.subscribed_channel = Hash.new
			user.subscribed_channel[:channel] = [ "channel_#{params[:user_id]}" ]
			user.save
		else
			user.subscribed_channel[:channel] << "channel_#{params[:user_id]}"
			user.save
		end
		redirect_to request.referer || root_path
	end

end