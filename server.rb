# frozen_string_literal: true

require 'oso'
require 'webrick'

require './expense'

OSO ||= Oso.new
OSO.register_class(Expense)
OSO.load_file('expenses.polar')

WEBrick::HTTPServer.new(Port: 5050).tap do |server|
  server.mount_proc '/' do |req, res|
    _, resource, id = req.path.split('/')
    # Look up the requested expense in our "database"
    expense = DB[id.to_i]

    # 404 if the requested path doesn't match /expenses/:id
    # or the requested expense ID doesn't exist in our "database"
    if resource != 'expenses' || expense.nil?
      res.status = 404
      res.body = "Not Found!\n"
      next
    end

    actor = req.header['user']&.first
    action = req.request_method

    if OSO.allowed?(actor: actor, action: action, resource: expense)
      res.body = expense.inspect + "\n"
    else
      res.status = 403
      res.body = "Not Authorized!\n"
    end
  end
  server.start
end
