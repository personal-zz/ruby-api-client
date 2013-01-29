module Personal
    module API
        module Config
            class << self
                attr_accessor :endpoint
                attr_accessor :prefix
                attr_accessor :client_id
                attr_accessor :client_secret
                attr_accessor :client_password
            end

            self.endpoint = "https://api-sandbox.personal.com"
            self.prefix = "/api/v1/"
            self.client_id = nil
            self.client_secret = nil
            self.client_password = nil
        end
    end
end