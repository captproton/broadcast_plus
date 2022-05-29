Rails.application.routes.draw do
  namespace :public do
    # get 'blog_entries/index'
    get 'blog_entries/show'
    get 'blog_entries/cosmo'
    get 'blog_entries/houston'
  end
  # See `config/routes/*.rb` to customize these configurations.
  draw "concerns"
  draw "devise"
  draw "sidekiq"

  # This is helpful to have around when working with shallow routes and complicated model namespacing. We don't use this
  # by default, but sometimes Super Scaffolding will generate routes that use this for `only` and `except` options.
  # TODO Would love to get this out of the application routes file.
  collection_actions = [:index, :new, :create]

  # This helps mark `resources` definitions below as not actually defining the routes for a given resource, but just
  # making it possible for developers to extend definitions that are already defined by the `bullet_train` Ruby gem.
  # TODO Would love to get this out of the application routes file.
  extending = {only: []}

  scope module: "public" do
    # To keep things organized, we put non-authenticated controllers in the `Public::` namespace.
    # The root `/` path is routed to `Public::HomeController#index` by default.
    draw "legal"
    draw "biography"
    draw "blog"
    draw "blog_entries"
    draw "blog_tags"
    draw "books"
    draw "events"
    draw "get_in_touch"
    draw "hireme"
    draw "media_appearances"
    draw "podcast"
    draw "press_kit"
    draw "wallpapers"
    # draw "customer_site"

  end

  namespace :webhooks do
    namespace :incoming do
      resources :bullet_train_webhooks
      namespace :oauth do
        # 🚅 super scaffolding will insert new oauth provider webhooks above this line.
      end
    end
  end

  namespace :account do
    shallow do
      # user-level onboarding tasks.
      namespace :onboarding do
        # routes for standard onboarding steps are configured in the `bullet_train` gem, but you can add more here.
      end

      # user specific resources.
      resources :users, extending do
        namespace :oauth do
          # 🚅 super scaffolding will insert new oauth providers above this line.
        end

        # routes for standard user actions and resources are configured in the `bullet_train` gem, but you can add more here.
      end

      # team-level resources.
      resources :teams, extending do
        # routes for many teams actions and resources are configured in the `bullet_train` gem, but you can add more here.

        # add your resources here.

        resources :invitations, extending do
          # routes for standard invitation actions and resources are configured in the `bullet_train` gem, but you can add more here.
        end

        resources :memberships, extending do
          # routes for standard membership actions and resources are configured in the `bullet_train` gem, but you can add more here.
        end

        namespace :integrations do
          # 🚅 super scaffolding will insert new integration installations above this line.
        end

        namespace :platform do
          resources :applications
        end

        resources :sites do
          resources :wallpapers
          resources :books do
            resources :merchandise_links
          end
          resources :events
          resources :media_appearances
          resources :publisher_accounts
          resources :images
          resources :biographies
          resources :blog_entries do
            resources :blog_articles
          end

          resources :blog_lists
          resources :setting_biographies
          resources :setting_book_collection_pages
          resources :setting_general_infos
          resources :setting_home_infos
          resources :setting_first_times
          resources :setting_get_in_contact_contents
          resources :setting_hire_mes
          resources :setting_event_pages
          resources :setting_podcasts
          resources :setting_press_kits do
            resources :press_kit_entries
            resources :press_kit_photo_and_headshots
            resources :press_kit_links
          end
          resources :setting_media_appearances_pages
          resources :setting_podcast_pages
        end
      end
    end
  end
end
