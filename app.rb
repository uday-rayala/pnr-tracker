require 'sinatra'
require 'sinatra/activerecord'
require './environments'
require './pnr_track_request'

get '/' do
  @requests = PnrTrackRequest.all
  erb :index
end

post "/add" do
  PnrTrackRequest.create(:pnr => params[:pnr])
  redirect "/", 302
end
