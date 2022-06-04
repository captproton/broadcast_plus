class CreateSettingPodcastPages < ActiveRecord::Migration[7.0]
  def change
    create_table :setting_podcast_pages do |t|
      t.references :site, null: false, foreign_key: true
      t.text :hero_title
      t.text :title
      t.text :podcast_player_src

      t.timestamps
    end
  end
end
