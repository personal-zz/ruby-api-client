$:.push File.expand_path("../lib", __FILE__)
require "personal_api_client/version"

Gem::Specification.new do |s|
  s.name        = 'personal_api_client'
  s.version     = PersonalApi::VERSION
  s.date        = '2012-10-31'
  s.summary		= "Personal API Client"
  s.description = "Personal library for easier interaction with Personal API"
  s.authors     = ["Adnan Karac"]
  s.add_runtime_dependency "oauth2", ["= 0.8.0"]
  s.add_development_dependency 'rspec', '~> 2.5'
  s.email       = 'adnan@personal.com'
  s.files       = `git ls-files`.split($\)
  s.test_files  = Dir.glob("{spec,test}/**/*.rb")
  s.require_paths = ["lib"]
  s.rubyforge_project = 'personal_api_client'
  s.homepage    = ""
  #["lib/oauth2_client.rb", "lib/personal_api_client.rb"]
end

