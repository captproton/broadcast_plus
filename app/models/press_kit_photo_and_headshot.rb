class PressKitPhotoAndHeadshot < ApplicationRecord
  # 🚅 add concerns above.

  belongs_to :setting_press_kit
  # 🚅 add belongs_to associations above.

  # 🚅 add has_many associations above.

  has_one :team, through: :setting_press_kit
  has_one_attached :photo
  # 🚅 add has_one associations above.
  scope :published_headshots,     -> { where("headshot_or_other = ?", "headshot").where("publish_at <= ?", Time.now)}
  scope :published_action_shots,  -> { where("headshot_or_other != ?", "headshot").where("publish_at <= ?", Time.now)}
  # 🚅 add scopes above.

  validates :title, presence: true
  # 🚅 add validations above.

  # 🚅 add callbacks above.

  # 🚅 add delegations above.

  # 🚅 add methods above.
end
