class CreateSettingGetInTouches < ActiveRecord::Migration[7.0]
  def change
    create_table :setting_get_in_touches do |t|
      t.string :first_name
      t.string :last_name
      t.text :youtube_url
      t.text :youtube_image_url

      t.timestamps
    end
  end
end
