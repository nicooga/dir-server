class Router
  def initialize(routes)    
    @routes = routes
  end

  def default
    [ 404, {'Content-Type' => 'text/plain'}, 'file not found' ]
  end

  def call(env)
    @routes.select do |route|
    end
    
    default
  end
end