resources :podcast, only: [:index]
get "podcast", to: "podcast#index"

