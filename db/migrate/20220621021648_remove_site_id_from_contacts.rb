class RemoveSiteIdFromContacts < ActiveRecord::Migration[7.0]
  def change
    remove_column :contacts, :site_id, :integer
  end
end
