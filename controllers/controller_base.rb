require 'rack'
require 'haml'
require 'yaml'

class ControllerBase
  def call(env)
    @env      = env
    @response = Rack::Response.new
    @request  = Rack::Request.new(env)
    @params   = @request.params
    @cookies  = @request.cookies

    # #app is another instance method where all the
    # stuff to be done happens. This method should 
    # modify the instance variable @response.
    app

    # App method will modify the @response variable
    # #method_missing allows me to call finish on it
    # just like this:
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