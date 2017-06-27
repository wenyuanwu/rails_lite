require 'rack'
require_relative '../lib/controller_base'

class MyController < ControllerBase
  def go
    if @req.path == "/cats"
      render_content("hello cats!", "text/html")
    else
      redirect_to("/cats")
    end
  end
end


# class ControllerBase

#   def initialize(req,res)
#     @req = req
#     @res = res
#   end 

#   def render_content(content, content_type) 
#     @already_build_response ||= @res
#     if @already_build_response
#       flash[:erorrs] = ["Render twice"]
#     end 
#     @res.body = content
#     @res['Content-Type'] = content_type
#   end 

#   def redirect_to(url) 
#     @res['Location'] = url
#     @res.status = 302
#   end 

# end 


app = Proc.new do |env|
  req = Rack::Request.new(env)
  res = Rack::Response.new
  MyController.new(req, res).go
  res.finish
end

Rack::Server.start(
  app: app,
  Port: 3000
)

