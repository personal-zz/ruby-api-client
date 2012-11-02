require 'oauth2'

class Oauth2Client
  @@oauth_config = nil
  @@callback_uri = nil

  attr_accessor :authorize_url
  attr_accessor :strategy
  attr_accessor :client

  def self.initialize_auth_code(options={})
    c = Oauth2Client.new(options[:client_id], options[:client_secret], options[:target_site])
    c.authorize_url = c.client.auth_code.authorize_url(:redirect_uri => options[:callback_uri], :scope => options[:scope])
    c.strategy = :auth_code
    @@callback_uri = Oauth2Client.callback_uri
    c
  end

  def self.initialize_client_auth(options={})
    c = Oauth2Client.new(options[:client_id], options[:client_secret], options[:target_site])
    c.strategy = :client_credentials
    c
  end

  def self.initialize_from_configuration(path)
    @@oauth_config = YAML.load_file(File.new(path)) unless @@oauth_config
    Oauth2Client.initialize_auth_code({:client_id => Oauth2Client.client_id, 
                                       :client_secret => Oauth2Client.client_secret, 
                                       :target_site => Oauth2Client.target_site, 
                                       :callback_uri => Oauth2Client.callback_uri, 
                                       :scope => Oauth2Client.scope})
  end

  def get_access_token(options={})
    params = prepare_params options
    @client.send(strategy).send(:get_token, *params)    
  end

  def self.callback_uri
    return @@callback_uri if @@callback_uri
    @@oauth_config[site]["my_site"] + @@oauth_config[site]["callback_uri"]
  end
 
  private
  def initialize(client_id, client_secret, target_site)
    @client = OAuth2::Client.new(client_id, client_secret, :site => target_site)
  end
  
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

  def prepare_params(params)
    if strategy==:auth_code
      raise Oauth2ClientException("You must specify code and callback_uri") unless params[:code] && params[:callback_uri]
      return_list = [params[:code], {:redirect_uri=>params[:callback_uri]}]
    elsif strategy==:client_credentials
      return_list = []
    end
    return_list
  end
end

class Oauth2ClientException < Exception
end
