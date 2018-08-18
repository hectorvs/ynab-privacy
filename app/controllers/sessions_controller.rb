# sessions_controller.rb
class SessionsController < ApplicationController

  def create
    auth = request.env['omniauth.auth']

    user = User.find(auth['uid']) || User.new

    user.id = auth['uid']
    user.provider = auth['provider']
    user.ynab_access_token = auth['credentials']['token']
    user.ynab_refresh_token = auth['credentials']['refresh_token']
    user.ynab_expires_at = Time.at(auth['credentials']['expires_at']).utc
    user.save!

    session[:user_id] = user.id
    redirect_to request.base_url, notice: 'Signed in!'
  end

  def destroy
    session[:user_id] = nil
    redirect_to request.base_url, notice: 'Signed out!'
  end

end
