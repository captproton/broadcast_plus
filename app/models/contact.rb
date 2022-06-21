class Contact < ApplicationRecord
    # belongs_to :site
    has_many :posts, as: :author
    has_many :conversations
    validates :email, :name, presence: true
end
