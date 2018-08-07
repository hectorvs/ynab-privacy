class CreateUsers < ActiveRecord::Migration[5.2]

  def change
    create_table :users do |t|
      t.string :uid
      t.string :provider
      t.string :privacy_key # TODO: look into encrypting this, attr_encrypted has error...

      t.timestamps
    end
  end
end
