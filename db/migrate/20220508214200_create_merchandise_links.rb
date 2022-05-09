class CreateMerchandiseLinks < ActiveRecord::Migration[7.0]
  def change
    create_table :merchandise_links do |t|
      t.string :seller_name
      t.string :item_url
      t.references :book, null: false, foreign_key: true
      t.references :site, null: false, foreign_key: true

      t.timestamps
    end
  end
end
