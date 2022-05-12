class CreateSettingEventPages < ActiveRecord::Migration[7.0]
  def change
    create_table :setting_event_pages do |t|
      t.references :site, null: false, foreign_key: true
      t.text :hero_title

      t.timestamps
    end
  end
end
