class CreateCaches < ActiveRecord::Migration
  def change
    create_table :caches do |t|
      t.string :url
      t.text :value

      t.timestamps null: false
    end
  end
end
