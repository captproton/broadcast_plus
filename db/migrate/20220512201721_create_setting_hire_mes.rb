class CreateSettingHireMes < ActiveRecord::Migration[7.0]
  def change
    create_table :setting_hire_mes do |t|
      t.references :site, null: false, foreign_key: true
      t.text :title
      t.text :learn_more_text
      t.text :learn_more_pdf_link

      t.timestamps
    end
  end
end
