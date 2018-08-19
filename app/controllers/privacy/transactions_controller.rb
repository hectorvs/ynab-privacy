module Privacy

  class TransactionsController < ApplicationController
    skip_before_filter :verify_authenticity_token

    def receive
      render nothing: true unless request.headers['Content-Type'] == 'application/json'

      privacy_transaction = JSON.parse(request.body.read)

      used_privacy_card_data = privacy_transaction['card']
      merchant_data = privacy_transaction['merchant']

      transaction_descriptor = merchant_data['descriptor'].to_s

      created_date = privacy_transaction['created'].to_s
      settled_amount = privacy_transaction['settled_amount'].to_i * 10

      card_link = CategoryCardLink.find_by_privacy_card_id(used_privacy_card_data['token'])
      render nothing: true unless card_link

      current_user(card_link.user_id)

      refresh_token_if_expired

      ynab_api.transactions.create_transaction(
          card_link.budget_id,
          {
              account_id: card_link.account_id,
              category_id: card_link.category_id,
              date: created_date,
              payee_name: transaction_descriptor,
              memo: 'Created using YNAB - Privacy.com linker :)',
              cleared: 'Cleared',
              approved: true,
              flag_color: 'Blue',
              amount:  settled_amount * 10
          }
      )

      render nothing: true

    rescue => e
      puts "ERROR: id=#{e.id}; name=#{e.name}; detail: #{e.detail}"
    end
  end
end
