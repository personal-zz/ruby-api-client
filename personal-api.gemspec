$:.push File.expand_path("../lib", __FILE__)
require "personal-api/version"

Gem::Specification.new do |s|
  s.name        = 'personal-api'
  s.version     = Personal::API::VERSION
  s.summary		= "Personal API Client"
  s.description = "Personal library for easier interaction with Personal API"
  s.authors     = ["Adnan Karac", "Mike Spainhower"]
  s.email       = 'dev@personal.com'
  s.homepage    = "https://github.com/Personal-Inc/ruby-api-client"
  
  s.rubyforge_project = 'personal_api_client'

  s.add_dependency "oauth2", ["~> 0.8"]
  s.add_development_dependency "rspec", "~> 2.6"

  s.files       = `git ls-files`.split("\n")
  s.require_paths = ["lib"]
end

