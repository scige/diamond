class AddShopsAndPromosRemarks < ActiveRecord::Migration
  def change
    add_column :shops, :remarks, :string
    add_column :promos, :remarks, :string
  end
end
