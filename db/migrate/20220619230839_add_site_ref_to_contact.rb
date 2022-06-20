class AddSiteRefToContact < ActiveRecord::Migration[7.0]
  def change
    add_reference :contacts, :site, null: false, foreign_key: true
  end
end
