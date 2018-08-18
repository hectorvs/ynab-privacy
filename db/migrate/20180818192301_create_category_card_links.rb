class CreateCategoryCardLinks < ActiveRecord::Migration[5.2]
  def change
    create_table :category_card_links, id: :uuid do |t|
      t.string :user_id
      t.string :account_id
      t.string :category_id
      t.string :category_name
      t.string :privacy_card_id
      t.string :privacy_card_name

      t.timestamps
    end
  end
end
