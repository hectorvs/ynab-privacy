require 'omniauth-oauth2'

module OmniAuth
  module Strategies
    class YnabAuth < OmniAuth::Strategies::OAuth2
      # Give your strategy a name.
      option :name, 'ynab_auth'

      # This is where you pass the options you would pass when
      # initializing your consumer from the OAuth gem.
      option :client_options,
             site: ENV['ynab_api_url'],
             authorize_url: "#{ENV['ynab_app_url']}/oauth/authorize",
             redirect_uri: 'https://localhost:3000/auth/ynab_auth/callback',
             response_type: 'code'

      # These are called after authentication has succeeded. If
      # possible, you should try to set the UID without making
      # additional calls (if the user id is returned with the token
      # or as a URI parameter). This may not be possible with all
      # providers.

      # profile.data.user.id
      uid { raw_info['data']['user']['id'] }

      info do
        {
        }
      end

      extra do
        {
            'raw_info' => raw_info
        }
      end

      def raw_info
        # puts access_token
        # @raw_info = { 'email': 'bla@bla.com', 'name': 'bla' }
        @raw_info ||= access_token.get('/v1/user').parsed
      end
    end
  end
end