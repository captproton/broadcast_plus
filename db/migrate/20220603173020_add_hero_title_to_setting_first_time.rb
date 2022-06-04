class AddHeroTitleToSettingFirstTime < ActiveRecord::Migration[7.0]
  def change
    add_column :setting_first_times, :hero_title, :string
  end
end
