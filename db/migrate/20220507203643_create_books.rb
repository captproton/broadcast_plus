class CreateBooks < ActiveRecord::Migration[7.0]
  def change
    create_table :books do |t|
      t.references :site, null: false, foreign_key: true
      t.string :title
      t.string :byline
      t.text :description
      t.text :jacket_url

      t.timestamps
    end
  end
end
