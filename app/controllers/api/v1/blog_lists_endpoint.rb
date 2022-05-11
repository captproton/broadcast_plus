class Api::V1::BlogListsEndpoint < Api::V1::Root
  helpers do
    params :site_id do
      requires :site_id, type: Integer, allow_blank: false, desc: "Site ID"
    end

    params :id do
      requires :id, type: Integer, allow_blank: false, desc: "Blog List ID"
    end

    params :blog_list do
      optional :title, type: String, desc: Api.heading(:title)
      optional :description, type: String, desc: Api.heading(:description)
      # 🚅 super scaffolding will insert new fields above this line.
      optional :tag_ids, type: Array, desc: Api.heading(:tag_ids)
      optional :blog_entry_ids, type: Array, desc: Api.heading(:blog_entry_ids)
      # 🚅 super scaffolding will insert new arrays above this line.

      # 🚅 super scaffolding will insert processing for new fields above this line.
    end
  end

  resource "sites", desc: Api.title(:collection_actions) do
    after_validation do
      load_and_authorize_api_resource BlogList
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
    get "/:site_id/blog_lists" do
      @paginated_blog_lists = paginate @blog_lists
      render @paginated_blog_lists, serializer: Api.serializer
    end

    #
    # CREATE
    #

    desc Api.title(:create), &Api.create_desc
    params do
      use :site_id
      use :blog_list
    end
    route_setting :api_resource_options, permission: :create
    oauth2 "write"
    post "/:site_id/blog_lists" do
      if @blog_list.save
        render @blog_list, serializer: Api.serializer
      else
        record_not_saved @blog_list
      end
    end
  end

  resource "blog_lists", desc: Api.title(:member_actions) do
    after_validation do
      load_and_authorize_api_resource BlogList
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
        render @blog_list, serializer: Api.serializer
      end
    end

    #
    # UPDATE
    #

    desc Api.title(:update), &Api.update_desc
    params do
      use :id
      use :blog_list
    end
    route_setting :api_resource_options, permission: :update
    oauth2 "write"
    route_param :id do
      put do
        if @blog_list.update(declared(params, include_missing: false))
          render @blog_list, serializer: Api.serializer
        else
          record_not_saved @blog_list
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
        render @blog_list.destroy, serializer: Api.serializer
      end
    end
  end
end
