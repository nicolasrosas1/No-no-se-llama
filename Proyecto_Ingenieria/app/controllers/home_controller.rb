class HomeController < ApplicationController
  include SessionsHelper
  before_action :current_user, :logged_in_user
end
