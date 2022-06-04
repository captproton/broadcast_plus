class Api::V1::SettingFirstTimesEndpoint < Api::V1::Root
  helpers do
    params :site_id do
      requires :site_id, type: Integer, allow_blank: false, desc: "Site ID"
    end

    params :id do
      requires :id, type: Integer, allow_blank: false, desc: "Setting First Time ID"
    end

    params :setting_first_time do
      optional :hero_title, type: String, desc: Api.heading(:hero_title)
      optional :hero_image, type: File, desc: Api.heading(:hero_image)
      optional :first_name, type: String, desc: Api.heading(:first_name)
      optional :last_name, type: String, desc: Api.heading(:last_name)
      optional :biography, type: String, desc: Api.heading(:biography)
      optional :featured_aside_image, type: File, desc: Api.heading(:featured_aside_image)
      optional :blurb, type: String, desc: Api.heading(:blurb)
      optional :twitter_handle, type: String, desc: Api.heading(:twitter_handle)
      optional :featured_youtube_video_url, type: String, desc: Api.heading(:featured_youtube_video_url)
      # 🚅 super scaffolding will insert new fields above this line.
      # 🚅 super scaffolding will insert new arrays above this line.

      # 🚅 super scaffolding will insert processing for new fields above this line.
    end
  end

  resource "sites", desc: Api.title(:collection_actions) do
    after_validation do
      load_and_authorize_api_resource SettingFirstTime
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
    get "/:site_id/setting_first_times" do
      @paginated_setting_first_times = paginate @setting_first_times
      render @paginated_setting_first_times, serializer: Api.serializer
    end

    #
    # CREATE
    #

    desc Api.title(:create), &Api.create_desc
    params do
      use :site_id
      use :setting_first_time
    end
    route_setting :api_resource_options, permission: :create
    oauth2 "write"
    post "/:site_id/setting_first_times" do
      if @setting_first_time.save
        render @setting_first_time, serializer: Api.serializer
      else
        record_not_saved @setting_first_time
      end
    end
  end

  resource "setting_first_times", desc: Api.title(:member_actions) do
    after_validation do
      load_and_authorize_api_resource SettingFirstTime
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
        render @setting_first_time, serializer: Api.serializer
      end
    end

    #
    # UPDATE
    #

    desc Api.title(:update), &Api.update_desc
    params do
      use :id
      use :setting_first_time
    end
    route_setting :api_resource_options, permission: :update
    oauth2 "write"
    route_param :id do
      put do
        if @setting_first_time.update(declared(params, include_missing: false))
          render @setting_first_time, serializer: Api.serializer
        else
          record_not_saved @setting_first_time
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
        render @setting_first_time.destroy, serializer: Api.serializer
      end
    end
  end
end
