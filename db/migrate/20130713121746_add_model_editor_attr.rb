class AddModelEditorAttr < ActiveRecord::Migration
  def change
    add_column :shops,  :editor, :string
    add_column :promos, :editor, :string

    add_index :coupons, :shop_id
  end
end
