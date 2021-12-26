# frozen_string_literal: true

require 'capybara/apparition'
require 'capybara/rspec'
require 'capybara-screenshot/rspec'

RSpec.configure do |config|
  config.before(:each, type: :system) do
    driven_by :apparition
    config.include Devise::Test::IntegrationHelpers
  end
end
