class ContactMessage < ApplicationRecord

  # after_create_commit lambda { 
  #   broadcast_prepend_to "contact_messages_list", target: "contact_messages"
  #  }
  
  #  after_update_commit lambda { 
  #   broadcast_prepend_to "contact_message_list", target: "#{dom_id self}_row"
  # }

  # 🚅 add concerns above.

  belongs_to :site
  # 🚅 add belongs_to associations above.

  # 🚅 add has_many associations above.

  has_one :team, through: :site
  # 🚅 add has_one associations above.

  # 🚅 add scopes above.

  validates :first_name, presence: true
  validates :email, presence: true
  validates :body, presence: true  
  # 🚅 add validations above.

  # 🚅 add callbacks above.

  # 🚅 add delegations above.

  # 🚅 add methods above.

end
