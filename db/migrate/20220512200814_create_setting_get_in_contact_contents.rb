class CreateSettingGetInContactContents < ActiveRecord::Migration[7.0]
  def change
    create_table :setting_get_in_contact_contents do |t|
      t.references :site, null: false, foreign_key: true
      t.text :first_name
      t.text :last_name
      t.text :youtube_url
      t.text :youtube_image_url

      t.timestamps
    end
  end
end
