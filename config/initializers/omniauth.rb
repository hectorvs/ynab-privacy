require 'ynab_auth'

Rails.application.config.middleware.use OmniAuth::Builder do
  provider :ynab_auth,
           Rails.application.credentials.ynab[:client_id],
           Rails.application.credentials.ynab[:client_secret]
end

OmniAuth.config.logger = Rails.logger