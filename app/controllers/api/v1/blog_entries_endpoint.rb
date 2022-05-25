class Api::V1::BlogEntriesEndpoint < Api::V1::Root
  helpers do
    params :site_id do
      requires :site_id, type: Integer, allow_blank: false, desc: "Site ID"
    end

    params :id do
      requires :id, type: Integer, allow_blank: false, desc: "Blog Entry ID"
    end

    params :blog_entry do
      optional :title, type: String, desc: Api.heading(:title)
      optional :pinned_value, type: String, desc: Api.heading(:pinned_value)
      optional :publish_at, type: DateTime, desc: Api.heading(:publish_at)
      optional :seo_title, type: String, desc: Api.heading(:seo_title)
      optional :seo_description, type: String, desc: Api.heading(:seo_description)
      optional :hero_image, type: File, desc: Api.heading(:hero_image)
      optional :image, type: File, desc: Api.heading(:image)
      optional :summary, type: String, desc: Api.heading(:summary)
      # 🚅 super scaffolding will insert new fields above this line.
      # 🚅 super scaffolding will insert new arrays above this line.

      # 🚅 super scaffolding will insert processing for new fields above this line.
    end
  end

  resource "sites", desc: Api.title(:collection_actions) do
    after_validation do
      load_and_authorize_api_resource BlogEntry
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
    get "/:site_id/blog_entries" do
      @paginated_blog_entries = paginate @blog_entries
      render @paginated_blog_entries, serializer: Api.serializer
    end

    #
    # CREATE
    #

    desc Api.title(:create), &Api.create_desc
    params do
      use :site_id
      use :blog_entry
    end
    route_setting :api_resource_options, permission: :create
    oauth2 "write"
    post "/:site_id/blog_entries" do
      if @blog_entry.save
        render @blog_entry, serializer: Api.serializer
      else
        record_not_saved @blog_entry
      end
    end
  end

  resource "blog_entries", desc: Api.title(:member_actions) do
    after_validation do
      load_and_authorize_api_resource BlogEntry
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
        render @blog_entry, serializer: Api.serializer
      end
    end

    #
    # UPDATE
    #

    desc Api.title(:update), &Api.update_desc
    params do
      use :id
      use :blog_entry
    end
    route_setting :api_resource_options, permission: :update
    oauth2 "write"
    route_param :id do
      put do
        if @blog_entry.update(declared(params, include_missing: false))
          render @blog_entry, serializer: Api.serializer
        else
          record_not_saved @blog_entry
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
        render @blog_entry.destroy, serializer: Api.serializer
      end
    end
  end
end
