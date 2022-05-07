class Api::V1::WallpapersEndpoint < Api::V1::Root
  helpers do
    params :site_id do
      requires :site_id, type: Integer, allow_blank: false, desc: "Site ID"
    end

    params :id do
      requires :id, type: Integer, allow_blank: false, desc: "Wallpaper ID"
    end

    params :wallpaper do
      optional :name, type: String, desc: Api.heading(:name)
      # 🚅 super scaffolding will insert new fields above this line.
      # 🚅 super scaffolding will insert new arrays above this line.

      # 🚅 super scaffolding will insert processing for new fields above this line.
    end
  end

  resource "sites", desc: Api.title(:collection_actions) do
    after_validation do
      load_and_authorize_api_resource Wallpaper
    end

    #
    # INDEX
    #

    desc Api.title(:index), &Api.index_desc
    params do
      use :site_id
    end
    oauth2
    paginate per_page: 100
    get "/:site_id/wallpapers" do
      @paginated_wallpapers = paginate @wallpapers
      render @paginated_wallpapers, serializer: Api.serializer
    end

    #
    # CREATE
    #

    desc Api.title(:create), &Api.create_desc
    params do
      use :site_id
      use :wallpaper
    end
    route_setting :api_resource_options, permission: :create
    oauth2 "write"
    post "/:site_id/wallpapers" do
      if @wallpaper.save
        render @wallpaper, serializer: Api.serializer
      else
        record_not_saved @wallpaper
      end
    end
  end

  resource "wallpapers", desc: Api.title(:member_actions) do
    after_validation do
      load_and_authorize_api_resource Wallpaper
    end

    #
    # SHOW
    #

    desc Api.title(:show), &Api.show_desc
    params do
      use :id
    end
    oauth2
    route_param :id do
      get do
        render @wallpaper, serializer: Api.serializer
      end
    end

    #
    # UPDATE
    #

    desc Api.title(:update), &Api.update_desc
    params do
      use :id
      use :wallpaper
    end
    route_setting :api_resource_options, permission: :update
    oauth2 "write"
    route_param :id do
      put do
        if @wallpaper.update(declared(params, include_missing: false))
          render @wallpaper, serializer: Api.serializer
        else
          record_not_saved @wallpaper
        end
      end
    end

    #
    # DESTROY
    #

    desc Api.title(:destroy), &Api.destroy_desc
    params do
      use :id
    end
    route_setting :api_resource_options, permission: :destroy
    oauth2 "delete"
    route_param :id do
      delete do
        render @wallpaper.destroy, serializer: Api.serializer
      end
    end
  end
end
