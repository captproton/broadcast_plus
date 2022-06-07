class Post < ApplicationRecord
  belongs_to :conversation
  belongs_to :author, polymorphic: true
  has_rich_text :body

  broadcasts_to :conversation

  # validates_presence_of :body, true
  validates_presence_of :body, on: :create, message: "can't be blank"
end
