class LinksController < ApplicationController

  def index
    render json: current_user.category_card_links
  end

  def create
    card_link = current_user.category_card_links.build(card_link_params)
    card_link.id = SecureRandom.uuid
    puts card_link
    card_link.save!

    render json: card_link
  end

  def destroy
    link = current_user.category_card_links.find(params[:id])
    link.delete

    render json: link
  end

  private

  def card_link_params
    params.require(:category_card_link).permit(:privacy_card_id, :account_id,
                                               :category_id, :category_id,
                                               :category_name,
                                               :privacy_card_name)
  end
end
