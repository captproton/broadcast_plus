class AddEmailSubscriberToContacts < ActiveRecord::Migration[7.0]
  def change
    add_column :contacts, :email_subscriber, :boolean
  end
end
