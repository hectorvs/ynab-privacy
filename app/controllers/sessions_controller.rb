# sessions_controller.rb
class SessionsController < ApplicationController

  def create
    auth = request.env['omniauth.auth']
    puts "EXPIRES AT FROM CREDS"
    puts auth['credentials']['expires_at']
    puts "all creds"
    puts auth['credentials']

    user = User.find_by_provider_and_uid(auth['provider'], auth['uid']) || User.create_with_omniauth(auth)
    session[:user_id] = user.id
    user.ynab_access_token = auth['credentials']['token']
    user.ynab_refresh_token = auth['credentials']['refresh_token']
    user.ynab_expires_at = Time.at(auth['credentials']['expires_at']).utc
    user.save
    redirect_to '/', notice: 'Signed in!'
  end

  def destroy
    session[:user_id] = nil
    redirect_to '/', notice: 'Signed out!'
  end

end
