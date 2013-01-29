$:.push File.expand_path("../lib", __FILE__)
require "personal-api/version"

Gem::Specification.new do |s|
  s.name        = 'personal_api_client'
  s.version     = Personal::API::VERSION
  s.summary		= "Personal API Client"
  s.description = "Personal library for easier interaction with Personal API"
  s.authors     = ["Adnan Karac", "Mike Spainhower"]
  s.add_runtime_dependency "oauth2", ["~> 0.8"]
  s.add_runtime_dependency "multi_json", ["~> 1.0"]
  s.email       = 'dev@personal.com'
  s.files       = `git ls-files`.split($\)
  s.require_paths = ["lib"]
  s.rubyforge_project = 'personal_api_client'
  s.homepage    = "https://github.com/Personal-Inc/ruby-api-client"
  #["lib/oauth2_client.rb", "lib/personal_api_client.rb"]
end

