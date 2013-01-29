module Personal
    module API
        class Error < StandardError
            attr_reader :status, :error, :error_description

            def initialize options = {:status=>-1, :error=>'UnknownError', :error_description=>"Unknown Error Occurred"}
                @status = options[:status]
                @error = options[:error]
                @error_description = options[:error_description]
            end
        end
    end
end