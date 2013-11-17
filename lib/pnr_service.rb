require 'httpclient'
require 'nokogiri'

class PnrService
  def self.status pnr
    response = HTTPClient.new.post "http://www.indianrail.gov.in/cgi_bin/inet_pnrstat_cgi.cgi", {:lccp_pnrno1 => pnr}, {"User-Agent"=>"PNR Tracker"}

    doc = Nokogiri::HTML(response.body)
    rows = doc.css('#center_table tr')

    chart_status = rows[-2].css('td')[1].text.strip

    passengers = rows[1..-3].map { |d|
      booking_status = d.css('td')[1].text.strip
      current_status = d.css('td')[2].text.strip
      [booking_status, current_status]
    }

    {
      :pnr => pnr,
      :valid => true,
      :chart_status => chart_status,
      :passengers => passengers
    }

  end
end
