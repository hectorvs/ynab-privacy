class ApplicationController < ActionController::Base

  helper_method :current_user

  def authentication_callback
    auth = request.env['omniauth.auth']
    # {
    #   "provider":"ynab_auth",
    #   "uid":"b71a4722-cffd-4035-ba53-bed89aaf27cb",
    #   "info":{"name":null,"email":null},
    #   "credentials":
    #       {
    #          "token":"a153fc56d0d0a42fd4898f8baa7ce49d8b58c9a323e89120e4c3ac97891cbe74",
    #          "refresh_token":"f93fb2d173080f28e1e19b22faf8fe846785c90ec18a82022c7504c20961c7cd",
    #           "expires_at":1533533434,
    #           "expires":true
    #        },
    # "extra": {
    #   "raw_info": {
    #     "data":{
    #         "user":{
    #             "id":"b71a4722-cffd-4035-ba53-bed89aaf27cb"
    #          }
    #      }
    #     }
    #  }
    # }
    render json: auth.to_json
  end

  private

  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end

  def refresh_token_if_expired
    return unless token_expired?

    response = RestClient.post "#{ENV['ynab_app_url']}/oauth/token",
                               grant_type: 'refresh_token',
                               refresh_token: session[:ynab_credentials]['refresh_token'],
                               client_id: Rails.application.credentials.ynab[:client_id],
                               client_secret: Rails.application.credentials.ynab[:client_secret]

    # response = {
    #     "access_token": "0cd3d1c4-1107-11e8-b642-0ed5f89f718b",
    #     "token_type": "bearer",
    #     "expires_in": 7200,
    #     "refresh_token": "13ae9632-1107-11e8-b642-0ed5f89f718b"
    # }
    refreshed_credentials = JSON.parse(response.body)

    session[:ynab_credentials]['token'] = refreshed_credentials['access_token']
    session[:ynab_credentials]['expires_at'] = (Time.now + refreshed_credentials['expires_in'].to_i).to_i
    puts 'refreshed credentials'
  end

  private

  def token_expired?
    expiry = Time.at(session[:ynab_credentials]['expires_at'])
    expiry < Time.now # expired token if the expiry time is less than current
  end

end
