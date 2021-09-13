require 'test/unit'
require 'rack/test'

require_relative './server'

class TestEverything < Test::Unit::TestCase
  include Rack::Test::Methods

  def app
    Sinatra::Application
  end

  def test_policy_loads_and_oso_inits
    assert OSO
  end

  def test_gmail_success
    get "/repo/gmail"
    assert last_response.ok?
  end

  def test_react_error
    get "/repo/react"
    assert !last_response.ok?
  end
end
