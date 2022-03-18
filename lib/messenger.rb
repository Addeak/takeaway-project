# Download the twilio-ruby library from twilio.com/docs/libraries/ruby
require 'twilio-ruby'
require 'dotenv/load'
def send(number)
  account_sid = ENV['TWILIO_ACCOUNT_SID']
  auth_token = ENV['TWILIO_AUTH_TOKEN']
  client = Twilio::REST::Client.new(account_sid, auth_token)

  from = '+17252151804' # Your Twilio number
  to = "#{number}" # Your mobile phone number

  time = Time.new
  delivery_time = "#{time.hour}:#{time.min + 30}"

  client.messages.create(
  from: from,
  to: to,
  body: "Your order has been confirmed and will be delivered by #{delivery_time}."
  )
end