class Book < ApplicationRecord
  # 🚅 add concerns above.

  belongs_to :site
  # 🚅 add belongs_to associations above.

  has_many :merchandise_links, dependent: :destroy, enable_updates: true
  # 🚅 add has_many associations above.

  has_one :team, through: :site
  # 🚅 add has_one associations above.

  # 🚅 add scopes above.

  validates :title, presence: true
  # 🚅 add validations above.

  # 🚅 add callbacks above.

  # 🚅 add delegations above.

  # 🚅 add methods above.
end
