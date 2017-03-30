class ApplicationController < ActionController::Base
  before_action :authenticate_request, if: :api_request?

  protect_from_forgery with: :exception
  include SessionsHelper

  # Confirms a logged-in user.
  def logged_in_user
    unless logged_in?
      flash[:danger] = "Please log in."
      redirect_to login_url
    end
  end

  private

  def authenticate_request
    @current_user = AuthorizeApiRequest.call(request.headers).result
    render json: { error: 'Not Authorized' }, status: 401 unless @current_user
  end

  def api_request?
    request.format.json? || request.xhr? # || request.format.xml
  end
end
