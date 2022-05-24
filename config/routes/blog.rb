get "blog", to: "blog#index"
resources :blog_entries, only: [:show]

