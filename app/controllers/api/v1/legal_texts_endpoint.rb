class Api::V1::LegalTextsEndpoint < Api::V1::Root
  helpers do
    params :site_id do
      requires :site_id, type: Integer, allow_blank: false, desc: "Site ID"
    end

    params :id do
      requires :id, type: Integer, allow_blank: false, desc: "Legal Text ID"
    end

    params :legal_text do
      optional :title, type: String, desc: Api.heading(:title)
      optional :body, type: String, desc: Api.heading(:body)
      # 🚅 super scaffolding will insert new fields above this line.
      # 🚅 super scaffolding will insert new arrays above this line.

      # 🚅 super scaffolding will insert processing for new fields above this line.
    end
  end

  resource "sites", desc: Api.title(:collection_actions) do
    after_validation do
      load_and_authorize_api_resource LegalText
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
    get "/:site_id/legal_texts" do
      @paginated_legal_texts = paginate @legal_texts
      render @paginated_legal_texts, serializer: Api.serializer
    end

    #
    # CREATE
    #

    desc Api.title(:create), &Api.create_desc
    params do
      use :site_id
      use :legal_text
    end
    route_setting :api_resource_options, permission: :create
    oauth2 "write"
    post "/:site_id/legal_texts" do
      if @legal_text.save
        render @legal_text, serializer: Api.serializer
      else
        record_not_saved @legal_text
      end
    end
  end

  resource "legal_texts", desc: Api.title(:member_actions) do
    after_validation do
      load_and_authorize_api_resource LegalText
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
        render @legal_text, serializer: Api.serializer
      end
    end

    #
    # UPDATE
    #

    desc Api.title(:update), &Api.update_desc
    params do
      use :id
      use :legal_text
    end
    route_setting :api_resource_options, permission: :update
    oauth2 "write"
    route_param :id do
      put do
        if @legal_text.update(declared(params, include_missing: false))
          render @legal_text, serializer: Api.serializer
        else
          record_not_saved @legal_text
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
        render @legal_text.destroy, serializer: Api.serializer
      end
    end
  end
end
