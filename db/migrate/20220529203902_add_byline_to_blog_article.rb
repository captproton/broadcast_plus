class AddBylineToBlogArticle < ActiveRecord::Migration[7.0]
  def change
    add_column :blog_articles, :byline, :string
  end
end
