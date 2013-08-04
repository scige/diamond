class ChangeLatitudeLongitudeType < ActiveRecord::Migration
  def change
    change_column :shops, :latitude, :decimal, :precision => 15, :scale => 10
    change_column :shops, :longitude, :decimal, :precision => 15, :scale => 10
  end
end
