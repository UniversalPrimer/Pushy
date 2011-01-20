# Sample Rack app using Pushy
# 1) Start an AMQP server (like RabbitMQ) on localhost
# 2) Run thin start -R example/config.ru
# 3) Browse to http://localhost:3000/ and follow instructions on the page
$: << File.dirname(__FILE__) + '/lib'
require "pushy"
require "logger"

use Rack::CommonLogger
use Rack::ShowExceptions

# This is just for development purpose, you'd normaly use the static pushy.js file
map "/" do
  run Pushy::App.new(:channel => Pushy::Channel::AMQP.new,
                      :logger => Logger.new(STDOUT))
end

