require File.expand_path('../lib/personal_api_client/version', __FILE__)

Gem::Specification.new do |s|
  s.name        = 'personal_api_client'
  s.version     = PersonalApiClient::VERSION
  s.date        = '2012-10-31'
  s.summary		= "Personal API Client"
  s.description = "Personal library for easier interaction with Personal API"
  s.authors     = ["Adnan Karac"]
  s.add_runtime_dependency "oauth2", ["= 0.8.0"]
  s.email       = 'adnan@personal.com'
  s.files       = `git ls-files`.split($\)
  s.require_paths = ["lib"]
  s.rubyforge_project = 'personal_api_client'
  s.homepage    = ""
  #["lib/oauth2_client.rb", "lib/personal_api_client.rb"]
end

