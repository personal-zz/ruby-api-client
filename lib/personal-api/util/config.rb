module Personal
    module API
        module Config
            class << self
                attr_accessor :endpoint
                attr_accessor :prefix
                attr_accessor :scope
                attr_accessor :callback_uri
                attr_accessor :client_id
                attr_accessor :client_secret
                attr_accessor :client_password
            end

            #defaults
            self.endpoint = "https://api-sandbox.personal.com"
            self.prefix = "/api/v1/"
            self.scope = "read_0000"
            self.callback_uri = nil
            self.client_id = nil
            self.client_secret = nil
            self.client_password = nil
        end
    end
end