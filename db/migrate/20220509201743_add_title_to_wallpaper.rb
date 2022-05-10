class AddTitleToWallpaper < ActiveRecord::Migration[7.0]
  def change
    add_column :wallpapers, :title, :string
  end
end
