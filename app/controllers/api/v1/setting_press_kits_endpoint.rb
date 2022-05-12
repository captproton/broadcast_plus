class Api::V1::SettingPressKitsEndpoint < Api::V1::Root
  helpers do
    params :site_id do
      requires :site_id, type: Integer, allow_blank: false, desc: "Site ID"
    end

    params :id do
      requires :id, type: Integer, allow_blank: false, desc: "Setting Press Kit ID"
    end

    params :setting_press_kit do
      optional :hero_title, type: String, desc: Api.heading(:hero_title)
      optional :hero_image, type: File, desc: Api.heading(:hero_image)
      optional :name, type: String, desc: Api.heading(:name)
      optional :birthplace, type: String, desc: Api.heading(:birthplace)
      optional :biography, type: String, desc: Api.heading(:biography)
      # 🚅 super scaffolding will insert new fields above this line.
      # 🚅 super scaffolding will insert new arrays above this line.

      # 🚅 super scaffolding will insert processing for new fields above this line.
    end
  end

  resource "sites", desc: Api.title(:collection_actions) do
    after_validation do
      load_and_authorize_api_resource SettingPressKit
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
    get "/:site_id/setting_press_kits" do
      @paginated_setting_press_kits = paginate @setting_press_kits
      render @paginated_setting_press_kits, serializer: Api.serializer
    end

    #
    # CREATE
    #

    desc Api.title(:create), &Api.create_desc
    params do
      use :site_id
      use :setting_press_kit
    end
    route_setting :api_resource_options, permission: :create
    oauth2 "write"
    post "/:site_id/setting_press_kits" do
      if @setting_press_kit.save
        render @setting_press_kit, serializer: Api.serializer
      else
        record_not_saved @setting_press_kit
      end
    end
  end

  resource "setting_press_kits", desc: Api.title(:member_actions) do
    after_validation do
      load_and_authorize_api_resource SettingPressKit
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
        render @setting_press_kit, serializer: Api.serializer
      end
    end

    #
    # UPDATE
    #

    desc Api.title(:update), &Api.update_desc
    params do
      use :id
      use :setting_press_kit
    end
    route_setting :api_resource_options, permission: :update
    oauth2 "write"
    route_param :id do
      put do
        if @setting_press_kit.update(declared(params, include_missing: false))
          render @setting_press_kit, serializer: Api.serializer
        else
          record_not_saved @setting_press_kit
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
        render @setting_press_kit.destroy, serializer: Api.serializer
      end
    end
  end
end
