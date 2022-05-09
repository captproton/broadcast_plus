class CreateImages < ActiveRecord::Migration[7.0]
  def change
    create_table :images do |t|
      t.references :site, null: false, foreign_key: true
      t.string :title

      t.timestamps
    end
  end
end
