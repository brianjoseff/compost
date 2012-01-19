class AddRoomNumberAndBuildingIdToSubscribers < ActiveRecord::Migration
  def change
    add_column :subscribers, :room_number, :string
    add_column :subscribers, :building_id, :integer
  end
end
