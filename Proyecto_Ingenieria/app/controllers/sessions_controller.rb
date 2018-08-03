class SessionsController < ApplicationController
  include SessionsHelper
  def new
  end

  def create
    user = User.find_by(nombre: params[:session][:usuario].downcase)
    if user && user.authenticate(params[:session][:usuario],params[:session][:password])
      log_in(user)
      redirect_to user
    else
      flash[:danger] = 'Invalid email/password combination'
      render 'new'
    end
  end

  def destroy
    log_out
    redirect_to '/login'
  end
end
