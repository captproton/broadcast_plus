class CreateContactMessages < ActiveRecord::Migration[7.0]
  def change
    create_table :contact_messages do |t|
      t.text :body

      t.timestamps
    end
  end
end
