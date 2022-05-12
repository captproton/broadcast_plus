class Api::V1::SettingHomeInfosEndpoint < Api::V1::Root
  helpers do
    params :site_id do
      requires :site_id, type: Integer, allow_blank: false, desc: "Site ID"
    end

    params :id do
      requires :id, type: Integer, allow_blank: false, desc: "Setting Home Info ID"
    end

    params :setting_home_info do
      optional :biography_blurb, type: String, desc: Api.heading(:biography_blurb)
      optional :video_billboard_url, type: String, desc: Api.heading(:video_billboard_url)
      optional :watch_this_video_url, type: String, desc: Api.heading(:watch_this_video_url)
      optional :bio_link_label, type: String, desc: Api.heading(:bio_link_label)
      optional :watch_this_poster_url, type: String, desc: Api.heading(:watch_this_poster_url)
      # 🚅 super scaffolding will insert new fields above this line.
      # 🚅 super scaffolding will insert new arrays above this line.

      # 🚅 super scaffolding will insert processing for new fields above this line.
    end
  end

  resource "sites", desc: Api.title(:collection_actions) do
    after_validation do
      load_and_authorize_api_resource SettingHomeInfo
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
    get "/:site_id/setting_home_infos" do
      @paginated_setting_home_infos = paginate @setting_home_infos
      render @paginated_setting_home_infos, serializer: Api.serializer
    end

    #
    # CREATE
    #

    desc Api.title(:create), &Api.create_desc
    params do
      use :site_id
      use :setting_home_info
    end
    route_setting :api_resource_options, permission: :create
    oauth2 "write"
    post "/:site_id/setting_home_infos" do
      if @setting_home_info.save
        render @setting_home_info, serializer: Api.serializer
      else
        record_not_saved @setting_home_info
      end
    end
  end

  resource "setting_home_infos", desc: Api.title(:member_actions) do
    after_validation do
      load_and_authorize_api_resource SettingHomeInfo
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
        render @setting_home_info, serializer: Api.serializer
      end
    end

    #
    # UPDATE
    #

    desc Api.title(:update), &Api.update_desc
    params do
      use :id
      use :setting_home_info
    end
    route_setting :api_resource_options, permission: :update
    oauth2 "write"
    route_param :id do
      put do
        if @setting_home_info.update(declared(params, include_missing: false))
          render @setting_home_info, serializer: Api.serializer
        else
          record_not_saved @setting_home_info
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
        render @setting_home_info.destroy, serializer: Api.serializer
      end
    end
  end
end
