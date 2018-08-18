class CreateUsers < ActiveRecord::Migration[5.2]
  # TODO: look into encrypting keys and tokens

  def change
    create_table :users do |t|
      t.string :uid
      t.string :provider
      t.string :privacy_key
      t.string :ynab_access_token
      t.string :ynab_refresh_token
      t.string :ynab_expires_at

      t.timestamps
    end
  end
end
