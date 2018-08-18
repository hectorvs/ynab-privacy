module Privacy
  class CardsController < ApplicationController
    before_action :require_user

    def index
      response = RestClient.get("#{ENV['privacy_api_url']}/card",
                                Authorization: "api-key #{current_user.privacy_key}")

      cards = JSON.parse(response)['data'].select do |card|
        card['state'] == 'OPEN'
      end

      render json: cards
    end
  end
end
