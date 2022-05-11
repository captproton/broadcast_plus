class CreateBlogLists < ActiveRecord::Migration[7.0]
  def change
    create_table :blog_lists do |t|
      t.references :blog_entry, null: false, foreign_key: true
      t.string :title

      t.timestamps
    end
  end
end
