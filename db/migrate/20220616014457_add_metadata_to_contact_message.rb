class AddMetadataToContactMessage < ActiveRecord::Migration[7.0]
  def change
    add_column :contact_messages, :first_name, :string
    add_column :contact_messages, :last_name, :string
    add_column :contact_messages, :email, :string
    add_column :contact_messages, :phone, :string
    add_column :contact_messages, :subject, :string
  end
end
