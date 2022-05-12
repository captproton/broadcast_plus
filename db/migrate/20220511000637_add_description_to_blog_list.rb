class AddDescriptionToBlogList < ActiveRecord::Migration[7.0]
  def change
    add_column :blog_lists, :description, :text
  end
end
