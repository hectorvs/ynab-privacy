require 'ynab_auth'

Rails.application.config.middleware.use OmniAuth::Builder do
  provider :ynab_auth,
           'f1b1ccb5db6969afc5e47fd5a3cfa1f22e827685b587ae9ca6d108da969cbd3f',
           '2697317998bf1e32e80ab8c7f497f1e28e79fd89a78b91033458405d9d476b5c'
end

OmniAuth.config.logger = Rails.logger