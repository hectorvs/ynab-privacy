# == Schema Information
#
# Table name: category_card_links
#
#  id              :uuid             not null, primary key
#  category_name   :string
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#  account_id      :string
#  category_id     :string
#  privacy_card_id :string
#  user_id         :string
#

class CategoryCardLink < ApplicationRecord
  belongs_to :user
end
