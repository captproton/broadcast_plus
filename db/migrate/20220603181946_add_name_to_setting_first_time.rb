class AddNameToSettingFirstTime < ActiveRecord::Migration[7.0]
  def change
    add_column :setting_first_times, :name, :string
  end
end
