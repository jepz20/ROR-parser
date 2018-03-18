class CreateContents < ActiveRecord::Migration
  def change
    create_table :contents do |t|
      t.string :tag
      t.string :text
      t.string :href
      t.references :page, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
