# resources :contact_messages

  # FIX: This approach currently does not work
# resources :contact_messages do
#     member do
#         post :edit
#     end
# end
  resources :contact_messages do
    member do
      post :edit
    end
  end