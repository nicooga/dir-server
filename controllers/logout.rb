require_relative 'controller_base.rb'

class Logout < ControllerBase
  def app
    delete_cookie(:_dir_server_session)
    redirect '/files'
  end
end