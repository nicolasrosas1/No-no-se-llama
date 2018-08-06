module SessionsHelper

  def log_in(user)
    session[:user_id] = user.id
    session[:cargo] = user.cargo
  end

  def current_user
    @current_user ||= User.find_by(id: session[:user_id])
  end

  def logged_in?
    !current_user.nil?
  end

  def logged_in_user
    unless logged_in?
      flash[:danger] = 'Inicie sesion por favor'
      redirect_to '/login'
    end
  end

  def log_out
    session.delete(:user_id)
    session.delete(:cargo)
    @current_user = nil
  end
end
