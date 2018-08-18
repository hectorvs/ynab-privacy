module Ynab
  class CategoriesController < ApplicationController
    before_action :require_user
    before_action :refresh_token_if_expired

    def index
      categories_response = ynab_api.categories.get_categories(params[:budget_id])

      @category_groups = categories_response.data.category_groups.select do |category_group|
        category_group.name != 'Internal Master Category' &&
          category_group.name != 'Hidden Categories'
      end

      render json: @category_groups
    end
  end
end
