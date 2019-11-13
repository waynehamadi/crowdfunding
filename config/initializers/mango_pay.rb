require 'mangopay'

MangoPay.configure do |c|
  c.preproduction = true

  c.client_id = ENV['MANGOPAY_CLIENT_ID']
  c.client_apiKey = ENV['MANGOPAY_CLIENT_API_KEY']
  c.log_file = File.join('log', 'mangopay.log')
  c.http_timeout = 10000
  p c.client_apiKey
end
