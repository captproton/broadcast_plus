class AddSiteRefToContactMessage < ActiveRecord::Migration[7.0]
  def change
    add_reference :contact_messages, :site, null: false, foreign_key: true
  end
end
