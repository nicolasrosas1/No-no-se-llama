class SessionsController < ApplicationController

  include SessionsHelper
  def new
  end

  def create
    user = User.find_by(correo: params[:session][:correo])
    if user && user.authenticate(params[:session][:correo],params[:session][:password])
      log_in(user)
      redirect_to '/home'
    else

    end
  end

  def destroy
    log_out
    redirect_to '/login'
  end
end
