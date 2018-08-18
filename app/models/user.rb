# == Schema Information
#
# Table name: users
#
#  id                 :integer          not null, primary key
#  privacy_key        :string
#  provider           :string
#  uid                :string
#  ynab_access_token  :string
#  ynab_expires_at    :string
#  ynab_refresh_token :string
#  created_at         :datetime         not null
#  updated_at         :datetime         not null
#

require 'rest-client'
require 'date'

class User < ApplicationRecord
  # {
  #   "provider":"ynab_auth",
  #   "uid":"b71a4722-cffd-4035-ba53-bed89aaf27cb",
  #   "info":{"name":null,"email":null},
  #   "credentials":
  #       {
  #          "token":"a153fc56d0d0a42fd4898f8baa7ce49d8b58c9a323e89120e4c3ac97891cbe74",
  #          "refresh_token":"f93fb2d173080f28e1e19b22faf8fe846785c90ec18a82022c7504c20961c7cd",
  #           "expires_at":1533533434,
  #           "expires":true
  #        },
  # "extra": {
  #   "raw_info": {
  #     "data":{
  #         "user":{
  #             "id":"b71a4722-cffd-4035-ba53-bed89aaf27cb"
  #          }
  #      }
  #     }
  #  }
  # }
  def self.create_with_omniauth(auth)
    create! do |user|
      user.provider = auth['provider']
      user.uid = auth['uid']
    end
  end

end
