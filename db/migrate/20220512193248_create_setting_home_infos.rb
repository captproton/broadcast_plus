class CreateSettingHomeInfos < ActiveRecord::Migration[7.0]
  def change
    create_table :setting_home_infos do |t|
      t.references :site, null: false, foreign_key: true
      t.text :biography_blurb
      t.text :video_billboard_url
      t.text :watch_this_video_url
      t.text :bio_link_label
      t.text :watch_this_poster_url

      t.timestamps
    end
  end
end
