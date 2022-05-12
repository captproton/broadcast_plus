class CreateBlogCards < ActiveRecord::Migration[7.0]
  def change
    create_table :blog_cards do |t|
      t.references :blog_list, null: false, foreign_key: true
      t.references :blog_entry, null: false, foreign_key: true
      t.string :title
      t.integer :pin_value

      t.timestamps
    end
  end
end
