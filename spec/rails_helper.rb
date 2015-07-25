# This file is copied to spec/ when you run 'rails generate rspec:install'
require 'spec_helper'
require 'devise'


RSpec.configure do |config|
  config.include Devise::TestHelpers, :type => :controller
  config.extend ControllerMacros, :type => :controller
end

def refresh_elasticsearch_cluster
  uri = URI.parse("http://127.0.0.1:9200/_refresh")
  response = Net::HTTP.post_form(uri, {})
end

