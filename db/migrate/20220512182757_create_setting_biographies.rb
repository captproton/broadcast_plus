class CreateSettingBiographies < ActiveRecord::Migration[7.0]
  def change
    create_table :setting_biographies do |t|
      t.references :site, null: false, foreign_key: true
      t.text :title

      t.timestamps
    end
  end
end
