class RegistrationsController < Devise::RegistrationsController

	def create
		super
		if resource.save
			resource.subscribed_channel = { channel: [ "channel_#{current_user.id}" ] }
			resource.save
		end
	end

	private

  def sign_up_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end

  def account_update_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation, :current_password)
  end
	
end