class CreateProducts < ActiveRecord::Migration
  def change
    create_table :products do |t|
      t.string  :name
      t.float   :price
      t.integer :sales, :default => 0
      t.integer :star, :default => 30
      t.references :shop

      t.timestamps
    end
  end
end
