require 'sinatra'
require 'sinatra/activerecord'
require './environments'


class PnrTrackRequest < ActiveRecord::Base
end

get '/' do
  @requests = PnrTrackRequest.all
  erb :index
end

post "/add" do
  PnrTrackRequest.create(:pnr => params[:pnr])
  redirect "/", 302
end
