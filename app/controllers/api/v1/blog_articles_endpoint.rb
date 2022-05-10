class Api::V1::BlogArticlesEndpoint < Api::V1::Root
  helpers do
    params :blog_entry_id do
      requires :blog_entry_id, type: Integer, allow_blank: false, desc: "Blog Entry ID"
    end

    params :id do
      requires :id, type: Integer, allow_blank: false, desc: "Blog Article ID"
    end

    params :blog_article do
      optional :pinned_value, type: String, desc: Api.heading(:pinned_value)
      optional :body, type: String, desc: Api.heading(:body)
      # 🚅 super scaffolding will insert new fields above this line.
      # 🚅 super scaffolding will insert new arrays above this line.

      # 🚅 super scaffolding will insert processing for new fields above this line.
    end
  end

  resource "blog_entries", desc: Api.title(:collection_actions) do
    after_validation do
      load_and_authorize_api_resource BlogArticle
    end

    #
    # INDEX
    #

    desc Api.title(:index), &Api.index_desc
    params do
      use :blog_entry_id
    end
    oauth2
    paginate per_page: 100
    get "/:blog_entry_id/blog_articles" do
      @paginated_blog_articles = paginate @blog_articles
      render @paginated_blog_articles, serializer: Api.serializer
    end

    #
    # CREATE
    #

    desc Api.title(:create), &Api.create_desc
    params do
      use :blog_entry_id
      use :blog_article
    end
    route_setting :api_resource_options, permission: :create
    oauth2 "write"
    post "/:blog_entry_id/blog_articles" do
      if @blog_article.save
        render @blog_article, serializer: Api.serializer
      else
        record_not_saved @blog_article
      end
    end
  end

  resource "blog_articles", desc: Api.title(:member_actions) do
    after_validation do
      load_and_authorize_api_resource BlogArticle
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
        render @blog_article, serializer: Api.serializer
      end
    end

    #
    # UPDATE
    #

    desc Api.title(:update), &Api.update_desc
    params do
      use :id
      use :blog_article
    end
    route_setting :api_resource_options, permission: :update
    oauth2 "write"
    route_param :id do
      put do
        if @blog_article.update(declared(params, include_missing: false))
          render @blog_article, serializer: Api.serializer
        else
          record_not_saved @blog_article
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
        render @blog_article.destroy, serializer: Api.serializer
      end
    end
  end
end
