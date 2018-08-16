require 'ynab'

module Ynab
  class BudgetsController < ApplicationController
    def index
      refresh_token_if_expired

      access_token = session[:ynab_credentials]['token']

      ynab = YNAB::API.new(access_token)

      budget_response = ynab.budgets.get_budgets
      @budgets = budget_response.data.budgets

      render json: @budgets
    end
  end
end

