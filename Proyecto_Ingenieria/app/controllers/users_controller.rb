class UsersController < ApplicationController

  include SessionsHelper

  def new
    @user = User.new
  end
  def create
    @user = User.new(user_params)
    if @user.save
      log_in(@user)

      redirect_to @user
    else
      render "new"
    end
  end

  def show
    @user = User.find_by(id: params[:id])
    puts @user.id
  end

  def update
  @user = User.find_by(id: params[:id])
    if @user.update_attributes(user_params)
      redirect_to @user

    else
      render(
        html: "<script>alert('No users!')</script>".html_safe,
        layout: 'application'
      )
    end
  end

  def user_params
    params.require(:user).permit(:nombre, :correo, :pass, :salt, :cargo, :apellido)
  end

  def update_params
    params.require(:user).permit(:apellido, :correo, :cargo, :nombre)
  end
end
