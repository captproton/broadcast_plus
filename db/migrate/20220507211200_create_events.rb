class CreateEvents < ActiveRecord::Migration[7.0]
  def change
    create_table :events do |t|
      t.references :site, null: false, foreign_key: true
      t.string :title
      t.date :start_date
      t.date :finish_date
      t.text :more_info_url
      t.string :location

      t.timestamps
    end
  end
end
