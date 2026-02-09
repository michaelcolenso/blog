class CreateClicks < ActiveRecord::Migration[7.1]
  def change
    create_table :clicks do |t|
      t.references :link, null: false, foreign_key: true
      t.references :page, null: false, foreign_key: true
      t.string :ip_address
      t.string :user_agent
      t.string :referrer
      t.string :country
      t.string :city
      t.datetime :clicked_at

      t.timestamps
    end
    add_index :clicks, :clicked_at
  end
end
