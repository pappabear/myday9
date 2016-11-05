class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  include SessionsHelper

  before_action :make_sure_there_is_a_working_date


  def make_sure_there_is_a_working_date
    session[:working_date] = Date.today.strftime("%m/%d/%Y") if session[:working_date].nil?
    session[:path] = 'Today' if session[:path].nil?
  end


  private

    # Confirms a logged-in user.
    def logged_in_user
      unless logged_in?
        store_location
        flash[:danger] = "Please log in."
        redirect_to login_url
      end
    end


end