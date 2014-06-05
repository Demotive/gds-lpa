require 'rubygems'
require 'sinatra'
require 'json'
require 'rack-cache'
require 'net/http'
require 'net/https'
#require 'active_support/core_ext/hash'
#require 'active_support/core_ext/object'

use Rack::Cache
set :public_folder, 'public'
set :bind, '0.0.0.0'

get '/' do
  File.read(File.join('public', 'index.html'))
end

#===========

# LPA live data
get '/lpa' do
  cache_control :public, :max_age => 20
  http = Net::HTTP.new('www.performance.service.gov.uk', 443)
  http.use_ssl = true
  req = Net::HTTP::Get.new("/data/lasting-power-of-attorney/volumes?")
  response = http.request(req)
  response.body
end