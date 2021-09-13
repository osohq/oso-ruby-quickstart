# frozen_string_literal: true

require 'oso'
require 'sinatra'

require_relative 'models'

OSO = Oso.new

OSO.register_class(User)
OSO.register_class(Repository)

OSO.load_files(["main.polar"])

get '/repo/:name' do
  repo = Repository.get_by_name(params['name'])

  begin
    OSO.authorize(User.get_current_user, "read", repo)
    "<h1>A Repo</h1><p>Welcome to repo #{repo.name}</p>"
  rescue Oso::NotFoundError
    status 404
    "<h1>Whoops!</h1><p>Repo named #{params['name']} was not found</p>"
  end
end

set :port, 5000
