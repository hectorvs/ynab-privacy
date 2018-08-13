require 'ynab'
require 'ostruct'

class LinksController < ApplicationController
  def index
    refresh_token_if_expired

    access_token = session[:ynab_credentials]['token']

    ynab = YNAB::API.new(access_token)

    begin
      budget_response = ynab.budgets.get_budgets
      @budgets = budget_response.data.budgets
    rescue => e
      puts "ERROR: #{e}"
    end

  end
end
