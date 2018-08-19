require 'ynab'

class ApplicationController < ActionController::Base

  helper_method :current_user
  helper_method :require_user
  helper_method :ynab_api

  def authentication_callback
    auth = request.env['omniauth.auth']
    render json: auth.to_json
  end

  private

  def require_user
    return true if current_user

    redirect_to request.base_url, notice: 'You must be logged in to access that page.'
  end

  def current_user(id = session[:user_id])
    @current_user ||= User.find(id) if id
  end

  def refresh_token_if_expired
    return unless token_expired?

    response = RestClient.post "#{ENV['ynab_app_url']}/oauth/token",
                               grant_type: 'refresh_token',
                               refresh_token: current_user.ynab_refresh_token,
                               client_id: Rails.application.credentials.ynab[:client_id],
                               client_secret: Rails.application.credentials.ynab[:client_secret]

    refreshed_credentials = JSON.parse(response.body)
    current_user.ynab_access_token = refreshed_credentials['access_token']
    current_user.ynab_expires_at = Time.now.utc + refreshed_credentials['expires_in'].seconds
    current_use.save!
  rescue StandardError => e
    session[:user_id] = nil
    # redirect_to request.base_url, notice: "Error Refreshing Token #{e.message}. Log back in."
  end

  def token_expired?
    Time.parse(current_user.ynab_expires_at) < Time.now.utc # expired token if the expiry time is less than current
  end

  def ynab_api
    YNAB::API.new(current_user.ynab_access_token) if current_user
  end

end
