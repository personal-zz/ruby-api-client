require 'oauth2'

class Oauth2Client
  @@oauth_config = nil
  @@callback_uri = nil

  attr_accessor :authorize_url
  
  def initialize(client_id, client_secret, target_site, callback_uri, scope=nil)
    @@callback_uri = callback_uri
    @@client = OAuth2::Client.new(client_id, client_secret, :site => target_site)
    @authorize_url = @@client.auth_code.authorize_url(:redirect_uri => callback_uri, :scope => scope)
  end
 
  def self.initialize_from_configuration(path)
    @@oauth_config = YAML.load_file(File.new(path)) unless @@oauth_config
    Oauth2Client.new(Oauth2Client.client_id, Oauth2Client.client_secret, Oauth2Client.target_site, Oauth2Client.callback_uri, Oauth2Client.scope)
  end

  def get_access_token(code, callback_uri)
    @@client.auth_code.get_token(code, :redirect_uri => callback_uri)
  end

  
  def client_id
    @@client.id
  end

  def self.callback_uri
    return @@callback_uri if @@callback_uri
    @@oauth_config[site]["my_site"] + @@oauth_config[site]["callback_uri"]
  end

 
  private
  
  def self.site
    @@oauth_config["site"]
  end

  def self.scope
    @@oauth_config[site]["scope"]
  end
  
  def self.client_id
    @client_id = @@oauth_config[site]["client_id"]
  end

  def self.client_secret
    @@oauth_config[site]["client_secret"]
  end

  def self.target_site
    @@oauth_config[site]["target_site"]
  end
end
