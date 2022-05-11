class AddSiteReferencesToBlogList < ActiveRecord::Migration[7.0]
  def change
    add_reference :blog_lists, :site, null: false, foreign_key: true
  end
end
