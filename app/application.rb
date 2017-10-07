require 'pry'

class Application

  def call(env)
    resp = Rack::Response.new
    req = Rack::Request.new(env)

    if req.path.match(/items/)
      item_requested = req.path.split("/items/").last
      #binding.pry
      if @@items.find {|item| item.name == item_requested}
        resp.write @@items.find {|item| item.name == item_requested}.price.to_s
      else
        resp.write "Item not found"
        resp.status = 400
      end
    else
      resp.write "Route not found"
      resp.status = 404
    end
    resp.finish
  end
end
