require_relative "test_helper"
require 'capybara/rails'
require 'webmock'

WebMock.disable_net_connect!

include OmniAuthStubHelper
prepare_omniauth_for_testing

class ActionDispatch::IntegrationTest
  include Capybara::DSL
  include OmniAuthStubHelper
end
