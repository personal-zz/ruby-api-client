require 'spec_helper'


describe PersonalApiClient do 

	it 'should return correct version string' do 
		PersonalApiClient.version_string.should == "#{PersonalApi::VERSION}"
	end

	it 'should return right path' do
		@client = PersonalApiClient.new(nil,nil)
		@client.api_path.should == "/api/v1"
    end

end
=begin
describe "#{api_path}" do
	it 'should return right path' do
		PersonalApiClient.api_path.should == "/api/v1"
	end
end
=end
