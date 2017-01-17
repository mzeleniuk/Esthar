class UsersController < ApplicationController
  before_action :authenticate_user!, only: [:update]

  def show
    respond_with User.find(params[:id])
  end

  def update
    user = User.find(params[:id])

    if (user == current_user) && user.update_attributes(user_params)
      respond_with user
    else
      render json: user.errors, success: false, status: 422
    end
  end

  private

  def user_params
    params.require(:user).permit(:email, :first_name, :last_name, :username, :date_of_birth, :phone, :website)
  end
end
