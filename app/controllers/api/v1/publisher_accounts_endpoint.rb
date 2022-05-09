class Api::V1::PublisherAccountsEndpoint < Api::V1::Root
  helpers do
    params :site_id do
      requires :site_id, type: Integer, allow_blank: false, desc: "Site ID"
    end

    params :id do
      requires :id, type: Integer, allow_blank: false, desc: "Publisher Account ID"
    end

    params :publisher_account do
      optional :name, type: String, desc: Api.heading(:name)
      optional :url, type: String, desc: Api.heading(:url)
      optional :font_awesome_class, type: String, desc: Api.heading(:font_awesome_class)
      optional :network_kind, type: String, desc: Api.heading(:network_kind)
      optional :blurb, type: String, desc: Api.heading(:blurb)
      optional :svg_logo, type: String, desc: Api.heading(:svg_logo)
      optional :svg_logo_style, type: String, desc: Api.heading(:svg_logo_style)
      optional :frontpage_ranking, type: String, desc: Api.heading(:frontpage_ranking)
      optional :sidebar_ranking, type: String, desc: Api.heading(:sidebar_ranking)
      optional :footer_ranking, type: String, desc: Api.heading(:footer_ranking)
      optional :podcast_ranking, type: String, desc: Api.heading(:podcast_ranking)
      # 🚅 super scaffolding will insert new fields above this line.
      # 🚅 super scaffolding will insert new arrays above this line.

      # 🚅 super scaffolding will insert processing for new fields above this line.
    end
  end

  resource "sites", desc: Api.title(:collection_actions) do
    after_validation do
      load_and_authorize_api_resource PublisherAccount
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
    get "/:site_id/publisher_accounts" do
      @paginated_publisher_accounts = paginate @publisher_accounts
      render @paginated_publisher_accounts, serializer: Api.serializer
    end

    #
    # CREATE
    #

    desc Api.title(:create), &Api.create_desc
    params do
      use :site_id
      use :publisher_account
    end
    route_setting :api_resource_options, permission: :create
    oauth2 "write"
    post "/:site_id/publisher_accounts" do
      if @publisher_account.save
        render @publisher_account, serializer: Api.serializer
      else
        record_not_saved @publisher_account
      end
    end
  end

  resource "publisher_accounts", desc: Api.title(:member_actions) do
    after_validation do
      load_and_authorize_api_resource PublisherAccount
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
        render @publisher_account, serializer: Api.serializer
      end
    end

    #
    # UPDATE
    #

    desc Api.title(:update), &Api.update_desc
    params do
      use :id
      use :publisher_account
    end
    route_setting :api_resource_options, permission: :update
    oauth2 "write"
    route_param :id do
      put do
        if @publisher_account.update(declared(params, include_missing: false))
          render @publisher_account, serializer: Api.serializer
        else
          record_not_saved @publisher_account
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
        render @publisher_account.destroy, serializer: Api.serializer
      end
    end
  end
end
