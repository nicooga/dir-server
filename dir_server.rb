require 'rack'
require 'digest'

### Controllers
require_relative 'controllers/router'
require_relative 'controllers/login'
require_relative 'controllers/logout'
require_relative 'controllers/index'

class DirServer < Rack::Server
  def initialize(dir, password)
    $dir = dir
    $session_token = Digest::SHA256.new.to_s
    $password_hash = Digest::SHA2.hexdigest(password + $session_token)
    super()
  end
  
  def app
    # Routes
    Router.new([
      draw(%r|^/$|, Index.new),
      draw(%r|^/login$|, Login.new),
      draw(%r|^/logout$|, Logout.new),
      draw(%r|^/files.*$|, Index.new),
      draw(%r|^/favicon\.ico$|, Favicon.new)
    ])
  end

  private

  def draw(pattern, controller)
    { pattern: pattern, controller: controller }
  end
end

DirServer.new(*ARGV).start