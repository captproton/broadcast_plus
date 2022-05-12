class Api::V1::SettingGeneralInfosEndpoint < Api::V1::Root
  helpers do
    params :site_id do
      requires :site_id, type: Integer, allow_blank: false, desc: "Site ID"
    end

    params :id do
      requires :id, type: Integer, allow_blank: false, desc: "Setting General Info ID"
    end

    params :setting_general_info do
      optional :site_name, type: String, desc: Api.heading(:site_name)
      optional :plain_text_name, type: String, desc: Api.heading(:plain_text_name)
      optional :text_number, type: String, desc: Api.heading(:text_number)
      optional :newsletter_subscription_url, type: String, desc: Api.heading(:newsletter_subscription_url)
      optional :default_meta_blurb, type: String, desc: Api.heading(:default_meta_blurb)
      optional :default_meta_image, type: File, desc: Api.heading(:default_meta_image)
      optional :is_team_website, type: Boolean, desc: Api.heading(:is_team_website)
      # 🚅 super scaffolding will insert new fields above this line.
      # 🚅 super scaffolding will insert new arrays above this line.

      # 🚅 super scaffolding will insert processing for new fields above this line.
    end
  end

  resource "sites", desc: Api.title(:collection_actions) do
    after_validation do
      load_and_authorize_api_resource SettingGeneralInfo
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
    get "/:site_id/setting_general_infos" do
      @paginated_setting_general_infos = paginate @setting_general_infos
      render @paginated_setting_general_infos, serializer: Api.serializer
    end

    #
    # CREATE
    #

    desc Api.title(:create), &Api.create_desc
    params do
      use :site_id
      use :setting_general_info
    end
    route_setting :api_resource_options, permission: :create
    oauth2 "write"
    post "/:site_id/setting_general_infos" do
      if @setting_general_info.save
        render @setting_general_info, serializer: Api.serializer
      else
        record_not_saved @setting_general_info
      end
    end
  end

  resource "setting_general_infos", desc: Api.title(:member_actions) do
    after_validation do
      load_and_authorize_api_resource SettingGeneralInfo
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
        render @setting_general_info, serializer: Api.serializer
      end
    end

    #
    # UPDATE
    #

    desc Api.title(:update), &Api.update_desc
    params do
      use :id
      use :setting_general_info
    end
    route_setting :api_resource_options, permission: :update
    oauth2 "write"
    route_param :id do
      put do
        if @setting_general_info.update(declared(params, include_missing: false))
          render @setting_general_info, serializer: Api.serializer
        else
          record_not_saved @setting_general_info
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
        render @setting_general_info.destroy, serializer: Api.serializer
      end
    end
  end
end
