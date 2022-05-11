class RemoveBlogEntryReferencesFromBlogList < ActiveRecord::Migration[7.0]
  def change
    remove_reference :blog_lists, :blog_entry, null: false, foreign_key: true
  end
end
