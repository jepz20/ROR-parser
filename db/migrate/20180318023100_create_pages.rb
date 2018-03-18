class CreatePages < ActiveRecord::Migration
  def change
    create_table :pages do |t|
      t.string :url
      t.timestamps null: false
    end
    add_index :pages, :url, unique: true
  end
end
