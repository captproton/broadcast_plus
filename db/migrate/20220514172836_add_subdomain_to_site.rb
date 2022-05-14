class AddSubdomainToSite < ActiveRecord::Migration[7.0]
  def change
    add_column :sites, :subdomain, :string
  end
end
