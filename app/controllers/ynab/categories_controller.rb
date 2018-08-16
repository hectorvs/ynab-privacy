require 'ynab'

module Ynab
  class CategoriesController < ApplicationController
    def index
      refresh_token_if_expired

      access_token = session[:ynab_credentials]['token']

      ynab = YNAB::API.new(access_token)

      budget_id = params[:budget_id]

      categories_response = ynab.categories.get_categories(budget_id)

      @category_groups = categories_response.data.category_groups

      render json: @category_groups
    end
  end
end
