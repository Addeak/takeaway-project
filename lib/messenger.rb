# Download the twilio-ruby library from twilio.com/docs/libraries/ruby
require 'twilio-ruby'
require 'dotenv/load'

account_sid = ENV['TWILIO_ACCOUNT_SID']
auth_token = ENV['TWILIO_AUTH_TOKEN']
client = Twilio::REST::Client.new(account_sid, auth_token)

from = '+17252151804' # Your Twilio number
to = '+447763717585' # Your mobile phone number

client.messages.create(
from: from,
to: to,
body: "YOU'RE A LOSER!!! HAHAHAHAHAHAHAHAHAHAHAHAHAHAHA"
)
