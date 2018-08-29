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
      flash[:success] = "Cambios correctos"
      redirect_to @user
    else
      flash[:danger] = "Ha ocurrido un error"
      render "new"
    end
  end

  def user_params
    params.require(:user).permit(:nombre, :correo, :pass, :salt, :cargo, :apellido, :bodega)
  end

  def update_params
    params.require(:user).permit(:apellido, :cargo, :nombre)
  end
end
