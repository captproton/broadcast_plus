class Api::V1::BooksEndpoint < Api::V1::Root
  helpers do
    params :site_id do
      requires :site_id, type: Integer, allow_blank: false, desc: "Site ID"
    end

    params :id do
      requires :id, type: Integer, allow_blank: false, desc: "Book ID"
    end

    params :book do
      optional :title, type: String, desc: Api.heading(:title)
      optional :byline, type: String, desc: Api.heading(:byline)
      optional :description, type: String, desc: Api.heading(:description)
      optional :jacket_url, type: String, desc: Api.heading(:jacket_url)
      # 🚅 super scaffolding will insert new fields above this line.
      # 🚅 super scaffolding will insert new arrays above this line.

      # 🚅 super scaffolding will insert processing for new fields above this line.
    end
  end

  resource "sites", desc: Api.title(:collection_actions) do
    after_validation do
      load_and_authorize_api_resource Book
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
    get "/:site_id/books" do
      @paginated_books = paginate @books
      render @paginated_books, serializer: Api.serializer
    end

    #
    # CREATE
    #

    desc Api.title(:create), &Api.create_desc
    params do
      use :site_id
      use :book
    end
    route_setting :api_resource_options, permission: :create
    oauth2 "write"
    post "/:site_id/books" do
      if @book.save
        render @book, serializer: Api.serializer
      else
        record_not_saved @book
      end
    end
  end

  resource "books", desc: Api.title(:member_actions) do
    after_validation do
      load_and_authorize_api_resource Book
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
        render @book, serializer: Api.serializer
      end
    end

    #
    # UPDATE
    #

    desc Api.title(:update), &Api.update_desc
    params do
      use :id
      use :book
    end
    route_setting :api_resource_options, permission: :update
    oauth2 "write"
    route_param :id do
      put do
        if @book.update(declared(params, include_missing: false))
          render @book, serializer: Api.serializer
        else
          record_not_saved @book
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
        render @book.destroy, serializer: Api.serializer
      end
    end
  end
end
