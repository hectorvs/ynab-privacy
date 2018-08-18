module Ynab
  class BudgetsController < ApplicationController
    before_action :require_user
    before_action :refresh_token_if_expired

    def index
      budget_response = ynab_api.budgets.get_budgets
      @budgets = budget_response.data.budgets

      render json: @budgets
    rescue StandardError => e
      render json: { message: e.message }, code: 500
    end
  end
end

