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

end
