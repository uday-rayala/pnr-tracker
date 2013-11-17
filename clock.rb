require 'clockwork'
require './app'
require 'httpclient'
require 'nokogiri'

include Clockwork

def pnr_status pnr
  response = HTTPClient.new.post "http://www.indianrail.gov.in/cgi_bin/inet_pnrstat_cgi.cgi", {:lccp_pnrno1 => pnr}, {"User-Agent"=>"PNR Tracker"}

  doc = Nokogiri::HTML(response.body)
  rows = doc.css('#center_table tr')

  return {:pnr => pnr, :valid => false } if rows.empty?

  chart_status = rows[-2].css('td')[1].text.strip

  passengers = rows[1..-3].map { |d|
    booking_status = d.css('td')[1].text.strip
    current_status = d.css('td')[2].text.strip
    [booking_status, current_status]
  }

  {
    :pnr => pnr,
    :valid => true,
    :chart => chart_status,
    :passengers => passengers
  }
end

every(2.minutes, 'Queueing interval job') {
  puts "Running.."
  PnrTrackRequest.all.each { |req|
    puts pnr_status req.pnr
  }
}
