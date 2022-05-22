class CreatePressKitLinks < ActiveRecord::Migration[7.0]
  def change
    create_table :press_kit_links do |t|
      t.references :setting_press_kit, null: false, foreign_key: true
      t.text :label
      t.text :url
      t.text :category

      t.timestamps
    end
  end
end
