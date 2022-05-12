class CreateSettingGeneralInfos < ActiveRecord::Migration[7.0]
  def change
    create_table :setting_general_infos do |t|
      t.references :site, null: false, foreign_key: true
      t.text :site_name
      t.text :plain_text_name
      t.text :text_number
      t.text :newsletter_subscription_url
      t.text :default_meta_blurb
      t.boolean :is_team_website

      t.timestamps
    end
  end
end
