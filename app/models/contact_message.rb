class ContactMessage < ApplicationRecord
  validates :body, presence: true

  after_create_commit lambda { 
    broadcast_prepend_to "contact_messages_list", target: "contact_messages"
   }
  
   after_update_commit lambda { 
    broadcast_prepend_to "contact_message_list", target: "#{dom_id self}_row"
  }
end
