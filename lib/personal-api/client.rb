
class PersonalApiClient
    PROTO = "https"
    HOST = "sandbox.personal.com"#TODO: move to config
    URL_PRE = "/api/v1/"

    def initialize access_token, client_id, client_secret, secure_password
        @at, @cid, @cs, @sp = access_token, client_id, client_secret, secure_password || client_secret

        conn_opts = {
            :params = {"client_id" => client_id}
            :headers = {
                "Content-Type" => "application/json",
                "Authorization" => "Bearer #{access_token}"
                "Secure-Password" => @sp
            }
        }
        @conn = Faraday.new("#{PROTO}://#{HOST}", conn_opts) do |faraday|
            faraday.response :logger
            faraday.adapter Faraday.default_adapter
        end
    end

    def get_gems_list filter
        if filter and ["my","others"].include? filter 
            get "gems/#{filter}"
        else
            get "gems"
        end
    end

    def get_gem gem_instance_id
        get "gems/#{gem_instance_id}"
    end

    def delete_gem gem_instance_id
        delete "gems/#{gem_instance_id}"
    end

    def write_gem gem_instance_id, gem
        put "gems/#{gem_instance_id}", gem
    end

    def create_gem gem
        post "gems", gem
    end

    def get_gem_schema gem_template_id=nil
        resource = "schema"
        resource << "/#{gem_template_id}" if gem_template_id
        get resource
    end

    def attach_file gem_instance_id, filename, io_obj
        @conn.post do |req|
            req.url "file"
            req.headers["Content-Type"] = "multipart/formdata"
            req.params["files[]"] = filename
            req.params["gem_id"] = gem_instance_id
            req.body = Faraday::UploadIO.new(io_obj, 'application/octet-stream', io_obj)
        end
    end

    #get_file
    def get_file file_id
        @conn.get do |req|
            req.url "file"
            req.body = Faraday::UploadIO.new(io_obj, 'application/octet-stream', io_obj)
        end
    end
    
    #delete_file
    private

    def get resource
        fire __method__, resource, nil
    end

    def delete resource
        fire __method__, resource, nil
    end

    def put resource, data
        fire __method__, resource, data
    end

    def post resource, data
        fire __method__, resource, data
    end

    def fire(verb, resource, body)
        @conn.method(verb).call do |req|
            req.url resource
            if body then req.body = JSON.stringify body end
        end
    end
end
