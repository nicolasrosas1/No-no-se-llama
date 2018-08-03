class UsersController < ApplicationController
  def new
    @user = User.new
  end
  def create
    @user = User.new(user_params)
    if @user.save
      flash[:notice] = "You signed up successfully"
      flash[:color]= "valid"
    else
      flash[:notice] = "Form is invalid"
      flash[:color]= "invalid"
    end
    render "new"
  end

  def show
    @user = User.find_by(params[:id])

  end

  def user_params
    params.require(:user).permit(:nombre, :correo, :pass, :salt, :cargo)
  end
end
