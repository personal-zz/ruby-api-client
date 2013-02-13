require 'test/unit'
require 'personal_api_client'

class TestRubyApi < Test::Unit::TestCase
	def test_version_string
		assert_equal PersonalApiClient.version_string, "#{PersonalApi::VERSION}"
	end
end

