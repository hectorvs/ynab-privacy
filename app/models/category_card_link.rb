# == Schema Information
#
# Table name: category_card_links
#
#  id                :uuid             not null, primary key
#  account_name      :string
#  budget_name       :string
#  category_name     :string
#  privacy_card_name :string
#  created_at        :datetime         not null
#  updated_at        :datetime         not null
#  account_id        :string
#  budget_id         :string
#  category_id       :string
#  privacy_card_id   :string
#  user_id           :string
#
# Indexes
#
#  index_category_card_links_on_privacy_card_id  (privacy_card_id) UNIQUE
#

class CategoryCardLink < ApplicationRecord
  belongs_to :user
end
