personal_api_client.gem
=======================

#INSTRUCTIONS:

1. Build the gem with following command: gem build personal_api_client.gemspec
2. Put following line in Gemfile of your application: gem 'personal_api_client', :path => "<path_to_the_folder_where_your_gem_is>"
3. Run bundle command
4. Congrats! You've succesfully built and installed the gem.


5. Getting the access token:
	5.1 Initialize your Personal Oauth2 Client: client = Oauth2Client.initialize_auth_code(parameters) where parameters are:

	{:client_id => <your_client_id>, 
     :client_secret => <your_client_secret>, 
     :target_site => <api_endpoint_i_e_https://api-sandbox.personal.com>, 
     :callback_uri => <path_to_your_method_where_authorization_code_will_be_sent_i_e_oauth2/my_callback_method>, 
     :scope => <scope_as_per_http://developer.personal.com/docs/read/authentication/Authorization_Code>}

    5.2 Redirect to authorize URL (recirect_to client.authorize_url)

    5.3 Authorization code will arrive to the callback URL you specified in :callback_uri. Call get_access_token:
    access_token = client.get_access_token(parameters) where parameters are:

    {:code => params[:code],
	 :callback_uri => <the_same_as_in_previous_request>}

6. Get the data
	6.1 Initialize Personal API Client:
	personal_api_client = PersonalApiClient.new(access_token, <your_client_id>)

	6.2 Use some of the methods of the client to manipulate data (consult http://developer.personal.com/docs if you need to assemble request body):


	Getting List of Gems:

  	get_list_of_gems
    
    Read Existing Gem:

  	get_gem(gem_instance_id)
    
  	Write to Existing Gem:

  	write_existing_gem(gem_instance_id, body, client_password)
    
  	Create New Gem:

  	create_gem(body, client_password)

  	Delete Existing Gem:

  	delete_gem(gem_instance_id)
    
    Remove Gem Access:

  	remove_gem_access(gem_instance_id, owner_id=nil)
    
  	Get Gem Schema:

  	get_gem_schema(gem_template_id=nil)
    
  	Get Gem Schema Version:

  	get_gem_schema_version
    
  	Granting Access:

  	grant_access(body, client_password)
    
  	Requesting Access:
  	
  	request_access(body)
    