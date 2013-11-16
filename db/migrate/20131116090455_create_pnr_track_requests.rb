class CreatePnrTrackRequests < ActiveRecord::Migration
  def up
    create_table :pnr_track_requests do |p|
      p.string :pnr
      p.timestamps
    end
  end

  def down
    drop_table :pnr_track_requests
  end
end
