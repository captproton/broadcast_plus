class CreatePressKitEntries < ActiveRecord::Migration[7.0]
  def change
    create_table :press_kit_entries do |t|
      t.text :title
      t.text :article_link
      t.date :publish_on
      t.datetime :release_at
      t.references :setting_press_kit, null: false, foreign_key: true

      t.timestamps
    end
  end
end
