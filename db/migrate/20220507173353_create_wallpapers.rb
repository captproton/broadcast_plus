class CreateWallpapers < ActiveRecord::Migration[7.0]
  def change
    create_table :wallpapers do |t|
      t.references :site, null: false, foreign_key: true
      t.string :name

      t.timestamps
    end
  end
end
