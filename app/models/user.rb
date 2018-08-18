# == Schema Information
#
# Table name: users
#
#  id                 :uuid             not null, primary key
#  privacy_key        :string
#  provider           :string
#  ynab_access_token  :string
#  ynab_expires_at    :string
#  ynab_refresh_token :string
#  created_at         :datetime         not null
#  updated_at         :datetime         not null
#

require 'rest-client'
require 'date'

class User < ApplicationRecord
  has_many :category_card_links

  def self.create_with_omniauth(auth)
    create! do |user|
      user.provider = auth['provider']
      user.uid = auth['uid']
    end
  end

end
