class CreatePublisherAccounts < ActiveRecord::Migration[7.0]
  def change
    create_table :publisher_accounts do |t|
      t.string :name
      t.text :url
      t.string :font_awesome_class
      t.string :network_kind
      t.string :blurb
      t.text :svg_logo
      t.text :svg_logo_style
      t.integer :frontpage_ranking, default: 0, null: false
      t.integer :sidebar_ranking, default: 0, null: false
      t.integer :footer_ranking, default: 0, null: false
      t.integer :podcast_ranking, default: 0, null: false
      t.references :site, null: false, foreign_key: true

      t.timestamps
    end
  end
end
