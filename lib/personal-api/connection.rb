module Personal
    module API
        class Connection
            attr_accessor :http_client

            def initialize at_hash, options = {}
                @oauth2_client = 
                @access_token = OAuth2::AccessToken.from_hash @oauth2_client, at_hash
                check_refresh
                conn_opts = {
                    #:ssl => { :verify_mode => OpenSSL::SSL::VERIFY_NONE },
                    :params => {"client_id" => Personal::API::Config.client_id},
                    :headers => {
                        "Authorization" => "Bearer #{@access_token.token}",
                        "Secure-Password" => (Personal::API::Config.client_password || Personal::API::Config.client_secret)
                    }
                }
                @http_client = Faraday.new(Personal::API::Config.endpoint, conn_opts) do |faraday|
                    faraday.response :logger
                    faraday.adapter Faraday.default_adapter
                end
            end

            def get_file file_id
                res = @http_client.get "file/#{URI::encode file_id}"
                if res.status == 200 then return res.body else err res end
            end

            def post_file gem_instance_id, filename, io_obj
                payload = Faraday::UploadIO.new(io_obj.tempfile, io_obj.content_type, io_obj.original_filename)
                
                res = @http_client.post "file", payload do |req|
                    req.headers["Content-Length"] = io_obj.tempfile.stat.size.to_s
                    req.headers["Content-Type"] = io_obj.content_type
                    req.params["files[]"] = filename
                    req.params["gem_id"] = gem_instance_id
                end

                if res.status == 200
                    #TODO: check for res.body.error
                    return JSON.parse res.body
                else
                    err res
                end
            end

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

            #PRIVATES
            private
            def check_refresh
                if @access_token.expired?
                    @access_token.refresh!
                    @http_client.headers {
                        "Authorization" => "Bearer #{@access_token.token}",
                        "Secure-Password" => (Personal::API::Config.client_password || Personal::API::Config.client_secret)
                    }
                end
            end

            def fire verb, resource, body
                res = @conn.method(verb).call do |req|
                    req.url "#{options[:prefix]}#{URI::encode resource}"
                    req.headers["Content-Type"] = "application/json"
                    if body then req.body = JSON.dump body end
                end
                
                if res.status == 200
                    return JSON.parse res.body, :symbolize_names=>true
                else
                    err res
                end
            end

            def err res
                begin
                    ex_opts = JSON.parse res.body, :symbolize_names=>true
                rescue
                    #TODO rescue Mashery html errors
                    ex_opts = {:error_description=>res.body}
                ensure
                    ex_opts[:status] = res.status
                    raise Personal::API::Error.new(ex_opts)
                end
            end
        end
    end
end