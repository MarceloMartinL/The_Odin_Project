# Include name
class RegistrationsController < Devise::RegistrationsController

	def create
		super
		#UserMailer.welcome_email(resource).deliver_now unless resource.invalid?
	end

	private

		def sign_up_params
			params.require(:user).permit(:name, :email, :password, :password_confirmation)
		end

		def account_update_params
			params.require(:user).permit(:name, :email, :password, :password_confirmation, :current_password)
		end
end