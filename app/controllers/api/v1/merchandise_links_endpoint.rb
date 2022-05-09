class Api::V1::MerchandiseLinksEndpoint < Api::V1::Root
  helpers do
    params :book_id do
      requires :book_id, type: Integer, allow_blank: false, desc: "Book ID"
    end

    params :id do
      requires :id, type: Integer, allow_blank: false, desc: "Merchandise Link ID"
    end

    params :merchandise_link do
      optional :seller_name, type: String, desc: Api.heading(:seller_name)
      optional :item_url, type: String, desc: Api.heading(:item_url)
      # 🚅 super scaffolding will insert new fields above this line.
      # 🚅 super scaffolding will insert new arrays above this line.

      # 🚅 super scaffolding will insert processing for new fields above this line.
    end
  end

  resource "books", desc: Api.title(:collection_actions) do
    after_validation do
      load_and_authorize_api_resource MerchandiseLink
    end

    #
    # INDEX
    #

    desc Api.title(:index), &Api.index_desc
    params do
      use :book_id
    end
    oauth2
    paginate per_page: 100
    get "/:book_id/merchandise_links" do
      @paginated_merchandise_links = paginate @merchandise_links
      render @paginated_merchandise_links, serializer: Api.serializer
    end

    #
    # CREATE
    #

    desc Api.title(:create), &Api.create_desc
    params do
      use :book_id
      use :merchandise_link
    end
    route_setting :api_resource_options, permission: :create
    oauth2 "write"
    post "/:book_id/merchandise_links" do
      if @merchandise_link.save
        render @merchandise_link, serializer: Api.serializer
      else
        record_not_saved @merchandise_link
      end
    end
  end

  resource "merchandise_links", desc: Api.title(:member_actions) do
    after_validation do
      load_and_authorize_api_resource MerchandiseLink
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
        render @merchandise_link, serializer: Api.serializer
      end
    end

    #
    # UPDATE
    #

    desc Api.title(:update), &Api.update_desc
    params do
      use :id
      use :merchandise_link
    end
    route_setting :api_resource_options, permission: :update
    oauth2 "write"
    route_param :id do
      put do
        if @merchandise_link.update(declared(params, include_missing: false))
          render @merchandise_link, serializer: Api.serializer
        else
          record_not_saved @merchandise_link
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
        render @merchandise_link.destroy, serializer: Api.serializer
      end
    end
  end
end
