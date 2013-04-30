require 'rack'
require 'haml'
require 'yaml'

class ControllerBase
  def call(env, meth = :get)
    @env      = env
    @response = Rack::Response.new
    @request  = Rack::Request.new(env)
    @params   = @request.params
    @cookies  = @request.cookies
    method(meth.downcase.to_sym).call
    finish
  end

  protected

  def logged?
    @cookies['_dir_server_session'] == $session_token
  end

  def check_logged
    redirect '/login' unless logged?
  end

  private

  def filter(sym)
    method(sym).call
  end

  def render(file_name, locales = {})
    write(Haml::Engine.new(
      File.read(File.join(Dir.pwd, 'views', "#{file_name}.haml"))
    ).render(self, locales))
  end

  def method_missing(m, *args, &block)
    @response.send(m, *args, &block)
  end
end