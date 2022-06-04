class CreatePressKitPhotoAndHeadshots < ActiveRecord::Migration[7.0]
  def change
    create_table :press_kit_photo_and_headshots do |t|
      t.text :title
      t.text :description
      t.text :dimensions_wxh
      t.text :headshot_or_other
      t.date :publish_at
      t.references :setting_press_kit, null: false, foreign_key: true

      t.timestamps
    end
  end
end
