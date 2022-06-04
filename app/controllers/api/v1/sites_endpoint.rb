class Api::V1::SitesEndpoint < Api::V1::Root
  helpers do
    params :team_id do
      requires :team_id, type: Integer, allow_blank: false, desc: "Team ID"
    end

    params :id do
      requires :id, type: Integer, allow_blank: false, desc: "Site ID"
    end

    params :site do
      optional :name, type: String, desc: Api.heading(:name)
      optional :subdomain, type: String, desc: Api.heading(:subdomain)
      # 🚅 super scaffolding will insert new fields above this line.
      # 🚅 super scaffolding will insert new arrays above this line.

      # 🚅 super scaffolding will insert processing for new fields above this line.
    end
  end

  resource "teams", desc: Api.title(:collection_actions) do
    after_validation do
      load_and_authorize_api_resource Site
    end

    #
    # INDEX
    #

    desc Api.title(:index), &Api.index_desc
    params do
      use :team_id
    end
    oauth2
    paginate per_page: 100
    get "/:team_id/sites" do
      @paginated_sites = paginate @sites
      render @paginated_sites, serializer: Api.serializer
    end

    #
    # CREATE
    #

    desc Api.title(:create), &Api.create_desc
    params do
      use :team_id
      use :site
    end
    route_setting :api_resource_options, permission: :create
    oauth2 "write"
    post "/:team_id/sites" do
      if @site.save
        render @site, serializer: Api.serializer
      else
        record_not_saved @site
      end
    end
  end

  resource "sites", desc: Api.title(:member_actions) do
    after_validation do
      load_and_authorize_api_resource Site
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
        render @site, serializer: Api.serializer
      end
    end

    #
    # UPDATE
    #

    desc Api.title(:update), &Api.update_desc
    params do
      use :id
      use :site
    end
    route_setting :api_resource_options, permission: :update
    oauth2 "write"
    route_param :id do
      put do
        if @site.update(declared(params, include_missing: false))
          render @site, serializer: Api.serializer
        else
          record_not_saved @site
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
        render @site.destroy, serializer: Api.serializer
      end
    end
  end
end
