require 'rack'
require 'digest'

### Controllers
require_relative 'controllers/router'
require_relative 'controllers/authentication'
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
    Router.new do |r|
      r.draw :get,    %r|^/$|,        Index, :index
      r.draw :get,    %r|^/files.*$|, Index, :index

      r.draw :get,    %r|^/login$|,   Authentication, :new
      r.draw :post,   %r|^/login$|,   Authentication, :create
      r.draw :post,   %r|^/logout$|,  Authentication, :delete
    end
  end
end

DirServer.new(*ARGV).start