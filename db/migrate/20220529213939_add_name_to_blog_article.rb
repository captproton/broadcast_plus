class AddNameToBlogArticle < ActiveRecord::Migration[7.0]
  def change
    add_column :blog_articles, :name, :string
  end
end
