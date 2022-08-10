class User < ApplicationRecord
  include Users::Base

  acts_as_messageable
  # 🚅 add concerns above.

  # 🚅 add belongs_to associations above.
    has_many :posts, as: :author

  # 🚅 add has_many associations above.

  # 🚅 add oauth providers above.

  # 🚅 add has_one associations above.

  # 🚅 add scopes above.

  # 🚅 add validations above.

  # 🚅 add callbacks above.

  # 🚅 add delegations above.

  def mailboxer_email(object)
    return email
  end

  def mailboxer_name
    self.name
  end

  # 🚅 add methods above.
end
