require 'ynab'

module Privacy

  class TransactionsController < ApplicationController
    skip_before_action :verify_authenticity_token

    def receive
      render nothing: true unless request.headers['Content-Type'] == 'application/json'

      puts "Processing things with #{JSON.parse(params)}"
      puts "Just FYI request.body.read #{JSON.parse(request.body.read)}"

      privacy_transaction = JSON.parse(params)


      used_privacy_card_data = privacy_transaction['card']
      merchant_data = privacy_transaction['merchant']
      transaction_descriptor = merchant_data['descriptor'].to_s
      created_date = privacy_transaction['created'].to_s
      settled_amount = privacy_transaction['settled_amount'].to_i * -10

      card_link = CategoryCardLink.find_by_privacy_card_id(used_privacy_card_data['token'])

      render body: nil unless card_link

      refresh_access_token_if_expired(card_link.user)

      ynab_client = YNAB::API.new(card_link.user.ynab_access_token)

      ynab_client.transactions.create_transaction(
          card_link.budget_id,
          {
              transaction: {
                  account_id: card_link.account_id,
                  category_id: card_link.category_id,
                  date: created_date,
                  payee_name: transaction_descriptor,
                  memo: 'Created using YNAB - Privacy.com linker :)',
                  cleared: 'Cleared',
                  approved: true,
                  amount:  settled_amount
              }
          }
      )

      render body: nil

    rescue => e
      puts "ERROR: id=#{e.id}; name=#{e.name}; detail: #{e.detail}"
    end

    private

    def refresh_access_token_if_expired(user)
      # no need to refrsh token if the expiry time is greater than current
      return if Time.parse(user.ynab_expires_at) > Time.now.utc

      response = RestClient.post "#{ENV['ynab_app_url']}/oauth/token",
                                 grant_type: 'refresh_token',
                                 refresh_token: user.ynab_refresh_token,
                                 client_id: Rails.application.credentials.ynab[:client_id],
                                 client_secret: Rails.application.credentials.ynab[:client_secret]

      refreshed_credentials = JSON.parse(response.body)

      user.ynab_access_token = refreshed_credentials['access_token']
      user.ynab_expires_at = Time.now.utc + refreshed_credentials['expires_in'].seconds
      user.save!
    end

  end
end
