class CreateLeads < ActiveRecord::Migration[7.0]
  def change
    create_table :leads do |t|
      t.string :name
      t.string :phone
      t.text :email_address
      t.text :subject
      t.text :message_body

      t.timestamps
    end
  end
end
