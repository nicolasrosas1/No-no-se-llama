class HomeController < ApplicationController
  include SessionsHelper
  include HomeHelper
  before_action :current_user, :logged_in_user
end
