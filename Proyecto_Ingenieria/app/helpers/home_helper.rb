require "json"
require "net/http"

module HomeHelper
  def iniciar
    uri = URI('http://localhost:3004/orders/')
    res = Net::HTTP::get_response(uri)
    # res = Net::HTTP.start(uri.hostname,uri.port) do |http|
    #   http.request(req)
    # end
    data = JSON.parse(res.body)
    
  end
end
