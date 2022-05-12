class CreateSettingBookCollectionPages < ActiveRecord::Migration[7.0]
  def change
    create_table :setting_book_collection_pages do |t|
      t.references :site, null: false, foreign_key: true
      t.text :title

      t.timestamps
    end
  end
end
