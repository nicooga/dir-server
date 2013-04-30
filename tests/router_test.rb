require 'awesome_print'
### Controllers

require_relative '../controllers/router'
require_relative '../controllers/login'
require_relative '../controllers/logout'
require_relative '../controllers/index'

router = Router.new do |r|
  r.draw :get,  %r|^/$|,        Index
  r.draw :get,  %r|^/login$|,   Login
  r.draw :post, %r|^/login$|,   Login
  r.draw :get,  %r|^/logout$|,  Login
  r.draw :get,  %r|^/files.*$|, Index
end

ap router.routes

match = router.routes.select do |route|
  route.pattern =~ env['REQUEST_PATH'] &&
  env['REQUEST_METHOD'] == route.meth
end[0]

ap match