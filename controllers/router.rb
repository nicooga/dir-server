class Router
  def initialize(routes)    
    @routes = routes
  end

  def default
    [ 404, {'Content-Type' => 'text/plain'}, 'file not found' ]
  end

  def call(env)
    @routes

    @routes.each do |route|
      if env['REQUEST_PATH'].match(route[:pattern])
        return route[:controller].call(env)
      end
    end

    default
  end
end