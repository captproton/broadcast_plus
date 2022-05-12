class AddArticleUrlToMediaAppearance < ActiveRecord::Migration[7.0]
  def change
    add_column :media_appearances, :article_url, :text
  end
end
