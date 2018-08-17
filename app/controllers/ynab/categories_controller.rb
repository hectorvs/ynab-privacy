require 'ynab'

module Ynab
  class CategoriesController < ApplicationController
    before_action :require_user

    def index
      refresh_token_if_expired

      ynab = YNAB::API.new(current_user.ynab_access_token)

      budget_id = params[:budget_id]

      categories_response = ynab.categories.get_categories(budget_id)

      @category_groups = categories_response.data.category_groups

      render json: @category_groups
    end
  end
end
