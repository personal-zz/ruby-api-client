#Personal API Client

The Personal API Client Gem allows you to quickly perform OAuth2 and basic operations to get you using the Personal API ASAP.

##Install

Manual Install:

    gem install personal_api_client

Gemfile:

    gem "personal_api_client", "~> 0.0.1"

Gemfile to stay bleeding edge (not recommended):

    gem "personal_api_client", :git => "git://github.com/Personal-Inc/ruby-api-client.git"

Remember to install:

    bundle install


## OAuth Flow:
### Initialize your Personal Oauth2 Client: 

    parameters = {:client_id => your_client_id, 
        :client_secret => your_client_secret, 
        :target_site => api_endpoint_i_e_https://api-sandbox.personal.com, 
        :callback_uri => path_to_your_method_where_authorization_code_will_be_sent_i_e_oauth2/my_callback_method, 
        :scope => scope_as_per_http://developer.personal.com/docs/read/authentication/Authorization_Code}

    client = Oauth2Client.initialize_auth_code(parameters)

### Redirect to authorize URL

    redirect_to client.authorize_url

### Authorization code will arrive to the callback URL you specified in first step
    
    parameters = {:code => params[:code], :callback_uri => the_same_as_in_previous_request}
    access_token = client.get_access_token(parameters)

##API Interaction

Initialize Personal API Client:
	
    personal_api_client = PersonalApiClient.new(access_token, your_client_id)

Use some of the methods of the client to manipulate data (consult http://developer.personal.com/docs if you need to assemble request body):

### Get List of Gems

    get_list_of_gems
    
### Read Existing Gem

    get_gem(gem_instance_id)
    
### Write to Existing Gem

    write_existing_gem(gem_instance_id, body, client_password)
    
### Create New Gem
 
    create_gem(body, client_password)

### Delete Existing Gem

    delete_gem(gem_instance_id)
    
### Remove Gem Access
    
    remove_gem_access(gem_instance_id, owner_id=nil)
    
### Get Gem Schema
    
    get_gem_schema(gem_template_id=nil)
    
### Get Gem Schema Version
    
    get_gem_schema_version
    
### Grant Access
    
    grant_access(body, client_password)
    
### Request Access

    request_access(body)

##See Also

* http://developer.personal.com/docs/
* https://rubygems.org/gems/personal_api_client

#Change Log

## Version 0.1.0 - February 1, 2013

- New structure that separates concerns ([@mike][]) 

## Version 0.0.1 - October 31, 2012

- Initial release to celebrate Halloween. ([@mike][])

[@mike]: https://github.com/mike-spainhower

#License

## MIT License

Copyright (c) 2012 Personal

Permission is hereby granted, free of charge, to any person
obtaining a copy of this software and associated documentation
files (the "Software"), to deal in the Software without
restriction, including without limitation the rights to use,
copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the
Software is furnished to do so, subject to the following
conditions:

The above copyright notice and this permission notice shall be
included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES
OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT
HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY,
WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
OTHER DEALINGS IN THE SOFTWARE.
