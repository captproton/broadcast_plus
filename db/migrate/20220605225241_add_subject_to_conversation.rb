class AddSubjectToConversation < ActiveRecord::Migration[7.0]
  def change
    add_column :conversations, :subject, :string
  end
end
