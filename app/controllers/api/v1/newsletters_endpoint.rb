class Api::V1::NewslettersEndpoint < Api::V1::Root
  helpers do
    params :site_id do
      requires :site_id, type: Integer, allow_blank: false, desc: "Site ID"
    end

    params :id do
      requires :id, type: Integer, allow_blank: false, desc: "Newsletter ID"
    end

    params :newsletter do
      optional :title, type: String, desc: Api.heading(:title)
      optional :mailing_group, type: String, desc: Api.heading(:mailing_group)
      optional :sender, type: String, desc: Api.heading(:sender)
      # 🚅 super scaffolding will insert new fields above this line.
      # 🚅 super scaffolding will insert new arrays above this line.

      # 🚅 super scaffolding will insert processing for new fields above this line.
    end
  end

  resource "sites", desc: Api.title(:collection_actions) do
    after_validation do
      load_and_authorize_api_resource Newsletter
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
    get "/:site_id/newsletters" do
      @paginated_newsletters = paginate @newsletters
      render @paginated_newsletters, serializer: Api.serializer
    end

    #
    # CREATE
    #

    desc Api.title(:create), &Api.create_desc
    params do
      use :site_id
      use :newsletter
    end
    route_setting :api_resource_options, permission: :create
    oauth2 "write"
    post "/:site_id/newsletters" do
      if @newsletter.save
        render @newsletter, serializer: Api.serializer
      else
        record_not_saved @newsletter
      end
    end
  end

  resource "newsletters", desc: Api.title(:member_actions) do
    after_validation do
      load_and_authorize_api_resource Newsletter
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
        render @newsletter, serializer: Api.serializer
      end
    end

    #
    # UPDATE
    #

    desc Api.title(:update), &Api.update_desc
    params do
      use :id
      use :newsletter
    end
    route_setting :api_resource_options, permission: :update
    oauth2 "write"
    route_param :id do
      put do
        if @newsletter.update(declared(params, include_missing: false))
          render @newsletter, serializer: Api.serializer
        else
          record_not_saved @newsletter
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
        render @newsletter.destroy, serializer: Api.serializer
      end
    end
  end
end
