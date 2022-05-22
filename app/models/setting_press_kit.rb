class SettingPressKit < ApplicationRecord
  # 🚅 add concerns above.

  belongs_to :site
  # 🚅 add belongs_to associations above.

  has_many :press_kit_entries, dependent: :destroy, enable_updates: true
  has_many :press_kit_photo_and_headshots, dependent: :destroy, enable_updates: true
  # 🚅 add has_many associations above.

  has_one :team, through: :site
  has_one_attached :hero_image
  has_rich_text :biography
  # 🚅 add has_one associations above.

  # 🚅 add scopes above.

  validates :hero_title, presence: true
  # 🚅 add validations above.

  # 🚅 add callbacks above.

  # 🚅 add delegations above.

  # 🚅 add methods above.
end
