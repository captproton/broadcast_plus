class RemoveSiteFromMerchandiseLink < ActiveRecord::Migration[7.0]
  def change
    remove_reference :merchandise_links, :site, null: false, foreign_key: true
  end
end
