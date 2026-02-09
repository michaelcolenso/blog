class CreateLinks < ActiveRecord::Migration[7.1]
  def change
    create_table :links do |t|
      t.references :page, null: false, foreign_key: true
      t.string :title
      t.string :url
      t.integer :position
      t.integer :clicks_count
      t.boolean :visible
      t.string :icon

      t.timestamps
    end
    add_index :links, :position
  end
end
