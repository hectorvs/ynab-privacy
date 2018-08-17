require 'ynab'

module Ynab
  class BudgetsController < ApplicationController
    before_action :require_user

    def index
      refresh_token_if_expired

      ynab = YNAB::API.new(current_user.ynab_access_token)

      budget_response = ynab.budgets.get_budgets
      @budgets = budget_response.data.budgets

      render json: @budgets
    end
  end
end

