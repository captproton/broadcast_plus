class MerchandiseLink < ApplicationRecord
  # 🚅 add concerns above.

  belongs_to :book
  # 🚅 add belongs_to associations above.

  # 🚅 add has_many associations above.

  has_one :team, through: :book
  # 🚅 add has_one associations above.

  # 🚅 add scopes above.

  validates :seller_name, presence: true
  # 🚅 add validations above.

  # 🚅 add callbacks above.

  # 🚅 add delegations above.

  # 🚅 add methods above.
end
