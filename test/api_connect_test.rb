require_relative 'api_connect'

foo = ApiClients.new("../config/config.yml")
client = foo.tumblr_init
p client.likes
