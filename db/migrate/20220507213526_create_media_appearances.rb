class CreateMediaAppearances < ActiveRecord::Migration[7.0]
  def change
    create_table :media_appearances do |t|
      t.references :site, null: false, foreign_key: true
      t.string :title
      t.date :published_on

      t.timestamps
    end
  end
end
