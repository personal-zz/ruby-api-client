require 'oauth2_client'

# TODO: create body builders for post request and make post requests parametrized
class PersonalApiClient
  API_VERSION_1 = "v1"
  API_PATH = "api"

  attr_accessor :client_id

  def api_path
    "/#{API_PATH}/#{API_VERSION_1}"
  end

  def initialize(at, cl_id)
    @access_token = at
    @client_id = cl_id
  end

  #Getting List of Gems
  def get_list_of_gems
    get(add_client_id_to "#{api_path}/gems/")
  end

  #Read Existing Gem
  def get_gem(gem_instance_id)
    get(add_client_id_to "#{api_path}/gems/#{gem_instance_id}")
  end

  #Write to Existing Gem
  def write_existing_gem(gem_instance_id, body, client_password)
    put(add_client_id_to "#{api_path}/gems/#{gem_instance_id}", {:body=>body, :headers=>{"Secure-Password"=>client_password }})
  end

  #Create New Gem
  def create_gem(body, client_password)
    post(add_client_id_to "#{api_path}/gems/", {:body=>body, :headers=>{"Secure-Password"=>client_password}})
  end

  #Delete Existing Gem
  def delete_gem(gem_instance_id)
    delete(add_client_id_to "#{api_path}/gems/#{gem_instance_id}")
  end

  #Remove Gem Access
  def remove_gem_access(gem_instance_id, owner_id=nil)
    delete(add_client_id_to "#{api_path}/gems/#{gem_instance_id}/access/#{owner_id}")
  end

  #Get Gem Schema
  def get_gem_schema(gem_template_id=nil)
    path_to_schema = "#{api_path}/schema"
    path_to_schema.concat("/#{gem_template_id}") if gem_template_id
    get(add_client_id_to path_to_schema)
  end

  #Get Gem Schema Version
  def get_gem_schema_version
    get(add_client_id_to "#{api_path}/schema/version")
  end

  #Granting Access
  def grant_access(body, client_password)
    post(add_client_id_to "#{api_path}/access/grant", {:body=>body, :headers=>{"Secure-Password"=>client_password}})
  end

  #Requesting Access
  def request_access(body)
    post(add_client_id_to "#{api_path}/access/request", :body=>body)
  end

  #Getting gem tags
  def get_gem_tags(gem_instance_id)
    get(add_client_id_to "#{api_path}/gems/#{gem_instance_id}/tags")
  end

  #Creating gem tags
  def create_gem_tags(gem_instance_id, tags=[])
    post(add_client_id_to "#{api_path}/gems/#{gem_instance_id}/tags", {"tag"=>tags.to_a})
  end

  def remove_gem_tags(gem_instance_id, tags=[])
    delete(add_client_id_to "#{api_path}/gems/#{gem_instance_id}/tags", {"tag"=>tags.to_a})
  end

  protected
  def get(resource, params = {})
    fire(__method__, resource, :params => params)
  end

  def post(resource, params = {})
    fire(__method__, resource, :params => params)
  end

  def put(resource, params = {})
    fire(__method__, resource, :params => params)
  end

  def delete(resource, params = {})
    fire(__method__, resource, :params => params)
  end

  private
  def fire(method_name, resource, params)
    response = @access_token.method(method_name).call(resource, :params => params)
    return response.status, response.parsed
  end

  def add_client_id_to(url)
    "#{url}?client_id=#{client_id}"
  end
end
