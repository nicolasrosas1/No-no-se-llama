class HomeController < ApplicationController
  include SessionsHelper
  before_action :current_user
end
