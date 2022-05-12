class CreateBlogEntries < ActiveRecord::Migration[7.0]
  def change
    create_table :blog_entries do |t|
      t.references :site, null: false, foreign_key: true
      t.string :title
      t.integer :pinned_value
      t.datetime :publish_at
      t.string :seo_title
      t.text :seo_description

      t.timestamps
    end
  end
end
