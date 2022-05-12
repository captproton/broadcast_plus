class CreateSettingFirstTimes < ActiveRecord::Migration[7.0]
  def change
    create_table :setting_first_times do |t|
      t.references :site, null: false, foreign_key: true
      t.text :first_name
      t.text :last_name
      t.text :blurb
      t.text :twitter_handle
      t.text :featured_image_src
      t.text :featured_youtube_video_url

      t.timestamps
    end
  end
end
