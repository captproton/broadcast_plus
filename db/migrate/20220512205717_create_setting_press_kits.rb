class CreateSettingPressKits < ActiveRecord::Migration[7.0]
  def change
    create_table :setting_press_kits do |t|
      t.references :site, null: false, foreign_key: true
      t.text :hero_title
      t.text :name
      t.date :birthdate
      t.text :birthplace

      t.timestamps
    end
  end
end
