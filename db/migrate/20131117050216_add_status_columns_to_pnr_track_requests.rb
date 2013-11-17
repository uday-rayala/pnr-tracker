class AddStatusColumnsToPnrTrackRequests < ActiveRecord::Migration
  def up
    add_column :pnr_track_requests, :date_of_travel, :date
    add_column :pnr_track_requests, :confirmed, :boolean
    add_column :pnr_track_requests, :details, :string
  end

  def down
    remove_column :pnr_track_requests, :date_of_travel
    remove_column :pnr_track_requests, :confirmed
    remove_column :pnr_track_requests, :details
  end
end
