class CreateBlogArticles < ActiveRecord::Migration[7.0]
  def change
    create_table :blog_articles do |t|
      t.references :blog_entry, null: false, foreign_key: true
      t.integer :pinned_value
      t.integer :last_updated_by_id

      t.timestamps
    end
  end
end
