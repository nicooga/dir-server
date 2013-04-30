require 'ostruct'

class Router
  attr_reader :routes

  def initialize    
    yield(@routes = Routes.new)
  end

  def call(env)
    route = @routes.select do |route|
      env['REQUEST_PATH'] =~ route.pattern &&
      env['REQUEST_METHOD'] == route.meth
    end[0]
    return route.controller.new.call(env, route.action) if route
    Rack::Response.new('This Is Not The Page You Are Looking For.', 404).finish
  end

  class Routes < Array
    def draw(method = :get, pattern = %r|/|, controller = ->{}, action = :index)
      self << OpenStruct.new(
        pattern: pattern,
        controller: controller,
        meth: method.to_s.gsub(/./, &:capitalize),
        action: action
      )
    end
  end
end