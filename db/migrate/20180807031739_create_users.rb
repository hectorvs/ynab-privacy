class CreateUsers < ActiveRecord::Migration[5.2]

  def change
    create_table :users do |t|
      t.string :uid
      t.string :provider
      t.string :privacy_key # TODO: look into encrypting this, attr_encrypted has error...
      t.string :ynab_access_token
      t.string :ynab_refresh_token
      t.datetime :ynab_expires_at


      t.timestamps
    end
  end
end
