class CreateNewsletters < ActiveRecord::Migration[7.0]
  def change
    create_table :newsletters do |t|
      t.references :site, null: false, foreign_key: true
      t.text :title
      t.text :mailing_group
      t.text :sender

      t.timestamps
    end
  end
end
