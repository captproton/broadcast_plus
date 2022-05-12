class CreateBiographies < ActiveRecord::Migration[7.0]
  def change
    create_table :biographies do |t|
      t.references :site, null: false, foreign_key: true
      t.string :title
      t.string :header_photo_url

      t.timestamps
    end
  end
end
