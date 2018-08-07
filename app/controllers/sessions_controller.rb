# sessions_controller.rb
class SessionsController < ApplicationController

  def create
    auth = request.env['omniauth.auth']
    user = User.find_by_provider_and_uid(auth['provider'], auth['uid']) || User.create_with_omniauth(auth)
    session[:user_id] = user.id
    session[:ynab_credentials] = auth['credentials']
    redirect_to '/', notice: 'Signed in!'
  end

  def destroy
    session[:user_id] = nil
    session[:ynab_credentials] = nil
    redirect_to '/', notice: 'Signed out!'
  end

end
