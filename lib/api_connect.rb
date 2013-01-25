require 'yaml'
require 'tumblr_client'
require 'instagram'

class ApiClient

  def initialize(yaml)
    @yml = YAML.load_file(yaml) 
  end

  def instagram_init
    Instagram.configure do |config|
      config.client_id = @yml['instagram']['client_id'] 
      config.client_secret = @yml['instagram']['client_secret'] 
    end

    return Instagram
  end

  def tumblr_init
    Tumblr.configure do |config|
      config.consumer_key = @yml['tumblr']['consumer_key']
      config.consumer_secret = @yml['tumblr']['consumer_secret']
      config.oauth_token = @yml['tumblr']['oauth_token']
      config.oauth_token_secret = @yml['tumblr']['oauth_token_secret']
    end

    return Tumblr.new
  end
end

