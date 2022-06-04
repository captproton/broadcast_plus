class SettingFirstTime < ApplicationRecord
  # 🚅 add concerns above.

  belongs_to :site
  # 🚅 add belongs_to associations above.

  # 🚅 add has_many associations above.

  has_one :team, through: :site
  has_rich_text :biography
  has_one_attached :hero_image
  has_one_attached :featured_aside_image
  # 🚅 add has_one associations above.

  # 🚅 add scopes above.

  validates :first_name, presence: true
  validates :hero_title, presence: true
  # 🚅 add validations above.

  # 🚅 add callbacks above.

  # 🚅 add delegations above.

  # 🚅 add methods above.
end
