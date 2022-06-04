class AddDomainToSite < ActiveRecord::Migration[7.0]
  def change
    add_column :sites, :domain, :text
  end
end
