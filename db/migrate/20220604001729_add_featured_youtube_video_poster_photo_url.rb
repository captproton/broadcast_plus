class AddFeaturedYoutubeVideoPosterPhotoUrl < ActiveRecord::Migration[7.0]
  def change
    add_column :setting_first_times, :youtube_video_poster_photo_url, :text
  end
end
