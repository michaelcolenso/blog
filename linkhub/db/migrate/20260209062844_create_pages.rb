class CreatePages < ActiveRecord::Migration[7.1]
  def change
    create_table :pages do |t|
      t.references :user, null: false, foreign_key: true
      t.string :handle
      t.string :title
      t.text :description
      t.string :theme
      t.string :avatar_url
      t.boolean :published
      t.integer :views_count

      t.timestamps
    end
    add_index :pages, :handle, unique: true
    add_index :pages, :views_count
  end
end
