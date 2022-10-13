class PasswordResetsController < ApplicationController
	def new
	end

	def create
		@user = User.find_by(email: params[:email])
		if @user.present?
			PasswordMailer.with(user: @user).reset.deliver_now
		end
		redirect_to root_path, notice: "A reset link was sent if the e-mail matches an account."
	end

	def edit
		@user = User.find_signed!(params[:token], purpose: "password_reset")
	rescue ActiveSupport::MessageVerifier::InvalidSignature
		redirect_to sign_in__path, alert: "Your token has expired, please reset again."
	end

	def update
		@user = User.find_signed!(params[:token], purpose: "password_reset")
		if @user.update(password_params)
			redirect_to sign_in_path, notice: "Your password was reset."
		else 
			render :edit, status: :unprocessable_entity
		end
	end

	private

	def password_params
		params.require(:user).permit(:password, :password_confirmation)
	end
end