class RegistrationsController < ApplicationController
	before_action :set_user, only: %i[ show edit update destroy ]

	def new
		@user = User.new
	end

	def create
		@user = User.new(user_params)
		@user.role = 1

		respond_to do |format|
      if @user.save
        session[:user_id] = @user.id
        format.html { redirect_to root_path, notice: "User was registered." }
      else
        format.html { render :new, status: :unprocessable_entity }
      end
    end

	end

	private
    # Use callbacks to share common setup or constraints between actions.
    def set_user
      @user = User.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def user_params
      params.require(:user).permit(:email, :password, :password_confirmation, :username)
    end
end