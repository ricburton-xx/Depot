class CreateProducts < ActiveRecord::Migration
  def self.up
    create_table :products do |t|
      t.string :title
      t.text :descript
      t.string :img_url

      t.timestamps
    end
  end

  def self.down
    drop_table :products
  end
end
