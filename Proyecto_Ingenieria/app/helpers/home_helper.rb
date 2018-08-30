require "json"
require "net/http"

module HomeHelper
  def iniciar
    uri = URI('http://localhost:3004/cotizaciones/')
    http = Net::HTTP.new(uri.host, uri.port)
    req = Net::HTTP::Get.new(uri.path)
    res = http.request(req)
    @data = JSON.parse(res.body)
    puts @data
  end
  def iniciar2
    uri = URI('http://localhost:3004/presupuestos/')
    http = Net::HTTP.new(uri.host, uri.port)
    req = Net::HTTP::Get.new(uri.path)
    res = http.request(req)
    @data2 = JSON.parse(res.body)
    puts @data2
  end
end
