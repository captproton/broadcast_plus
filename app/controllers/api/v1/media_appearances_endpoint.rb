class Api::V1::MediaAppearancesEndpoint < Api::V1::Root
  helpers do
    params :site_id do
      requires :site_id, type: Integer, allow_blank: false, desc: "Site ID"
    end

    params :id do
      requires :id, type: Integer, allow_blank: false, desc: "Media Appearance ID"
    end

    params :media_appearance do
      optional :title, type: String, desc: Api.heading(:title)
      optional :published_on, type: Date, desc: Api.heading(:published_on)
      optional :article_url, type: String, desc: Api.heading(:article_url)
      # 🚅 super scaffolding will insert new fields above this line.
      # 🚅 super scaffolding will insert new arrays above this line.

      # 🚅 super scaffolding will insert processing for new fields above this line.
    end
  end

  resource "sites", desc: Api.title(:collection_actions) do
    after_validation do
      load_and_authorize_api_resource MediaAppearance
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
    get "/:site_id/media_appearances" do
      @paginated_media_appearances = paginate @media_appearances
      render @paginated_media_appearances, serializer: Api.serializer
    end

    #
    # CREATE
    #

    desc Api.title(:create), &Api.create_desc
    params do
      use :site_id
      use :media_appearance
    end
    route_setting :api_resource_options, permission: :create
    oauth2 "write"
    post "/:site_id/media_appearances" do
      if @media_appearance.save
        render @media_appearance, serializer: Api.serializer
      else
        record_not_saved @media_appearance
      end
    end
  end

  resource "media_appearances", desc: Api.title(:member_actions) do
    after_validation do
      load_and_authorize_api_resource MediaAppearance
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
        render @media_appearance, serializer: Api.serializer
      end
    end

    #
    # UPDATE
    #

    desc Api.title(:update), &Api.update_desc
    params do
      use :id
      use :media_appearance
    end
    route_setting :api_resource_options, permission: :update
    oauth2 "write"
    route_param :id do
      put do
        if @media_appearance.update(declared(params, include_missing: false))
          render @media_appearance, serializer: Api.serializer
        else
          record_not_saved @media_appearance
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
        render @media_appearance.destroy, serializer: Api.serializer
      end
    end
  end
end
