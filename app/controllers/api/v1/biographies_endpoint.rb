class Api::V1::BiographiesEndpoint < Api::V1::Root
  helpers do
    params :site_id do
      requires :site_id, type: Integer, allow_blank: false, desc: "Site ID"
    end

    params :id do
      requires :id, type: Integer, allow_blank: false, desc: "Biography ID"
    end

    params :biography do
      optional :title, type: String, desc: Api.heading(:title)
      optional :header_photo_url, type: String, desc: Api.heading(:header_photo_url)
      optional :body, type: String, desc: Api.heading(:body)
      # 🚅 super scaffolding will insert new fields above this line.
      # 🚅 super scaffolding will insert new arrays above this line.

      # 🚅 super scaffolding will insert processing for new fields above this line.
    end
  end

  resource "sites", desc: Api.title(:collection_actions) do
    after_validation do
      load_and_authorize_api_resource Biography
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
    get "/:site_id/biographies" do
      @paginated_biographies = paginate @biographies
      render @paginated_biographies, serializer: Api.serializer
    end

    #
    # CREATE
    #

    desc Api.title(:create), &Api.create_desc
    params do
      use :site_id
      use :biography
    end
    route_setting :api_resource_options, permission: :create
    oauth2 "write"
    post "/:site_id/biographies" do
      if @biography.save
        render @biography, serializer: Api.serializer
      else
        record_not_saved @biography
      end
    end
  end

  resource "biographies", desc: Api.title(:member_actions) do
    after_validation do
      load_and_authorize_api_resource Biography
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
        render @biography, serializer: Api.serializer
      end
    end

    #
    # UPDATE
    #

    desc Api.title(:update), &Api.update_desc
    params do
      use :id
      use :biography
    end
    route_setting :api_resource_options, permission: :update
    oauth2 "write"
    route_param :id do
      put do
        if @biography.update(declared(params, include_missing: false))
          render @biography, serializer: Api.serializer
        else
          record_not_saved @biography
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
        render @biography.destroy, serializer: Api.serializer
      end
    end
  end
end
