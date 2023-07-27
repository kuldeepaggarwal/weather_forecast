# frozen_string_literal: true

class ApplicationController < ActionController::Base
  protected

  def current_user
    @current_user ||= GuestUser.new
  end
  helper_method :current_user
end
