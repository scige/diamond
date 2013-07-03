class CreatePromos < ActiveRecord::Migration
  def change
    create_table :promos do |t|
      t.string   :name
      t.text     :content
      t.datetime :begin_at
      t.datetime :end_at
      t.string   :thumb

      t.timestamps
    end
  end
end
