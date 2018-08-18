module Ynab
  class AccountsController < ApplicationController
    before_action :require_user
    before_action :refresh_token_if_expired

    def index
      accounts_response = ynab_api.accounts.get_accounts(params[:budget_id])

      @checking_accounts = accounts_response.data.accounts.select do |account|
        account.type == 'checking' && !account.closed && !account.deleted
      end

      render json: @checking_accounts
    end
  end
end
