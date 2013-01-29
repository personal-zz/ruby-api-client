module Personal
    module API
        class Client
            def initialize options
                @conn = Personal::API::Connection.new options[:at_hash]
            end

            def get_gems_list filter
                if filter and ["my","others"].include? filter 
                    @conn.get "gems/#{filter}"
                else
                    @conn.get "gems"
                end
            end

            def get_gem gem_instance_id
                @conn.get "gems/#{gem_instance_id}"
            end

            def delete_gem gem_instance_id
                @conn.delete "gems/#{gem_instance_id}"
            end

            def write_gem gem_instance_id, gem
                @conn.put "gems/#{gem_instance_id}", gem
            end

            def create_gem gem
                @conn.post "gems", gem
            end

            #Tags
            def tag_gem gem_instance_id, tag_arr
                body = {:tag => tag_arr}
                @conn.post "gems/#{gem_instance_id}/tags", body
            end

            def get_gem_tags gem_instance_id
                @conn.get "gems/#{gem_instance_id}/tags"
            end

            def browse_tag tag
                body = {
                    :metadata=> {
                        :tag => ["#{tag}"]
                    }
                }
                @conn.post("metadata/browse?object_type=profile&query=#{URI::encode tag}", body)
            end

            def untag_gem gem_instance_id, tag_arr
                body = {:tag => tag_arr}
                @conn.delete "gems/#{gem_instance_id}/tags", body
            end

            # Schema #
            def get_gem_schema gem_template_id=nil
                resource = "schema"
                resource << "/#{gem_template_id}" if gem_template_id
                @conn.get resource
            end

            #Access
            def grant_access gems_arr, owners_arr, message
                body = {
                    :gems => gems_arr,
                    :owners => owners_arr.map {|owner| {:type => "email", :value => owner}},
                    :message => message,
                    :allowadopt => false
                }
                @conn.post "access/grant", body
            end

            #Contacts
            def get_contacts
                @conn.get "contact"
            end

            # Files #
            def attach_file gem_instance_id, filename, io_obj
                @conn.post_file gem_instance_id, filename, io_obj
            end

            def get_file file_id
                @conn.get_file file_id
            end
         end
    end
end
