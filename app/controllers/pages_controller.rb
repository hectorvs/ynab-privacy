class PagesController < ApplicationController
  layout 'empty_layout', only: :category_links

  def index; end

  def category_links; end

  def privacy_policy; end
end