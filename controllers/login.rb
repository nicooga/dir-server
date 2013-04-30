require_relative 'controllers/controller_base.rb'

class Login < ControllerBase
  def app
    authenticate if @params['password']
    render :auth
  end

  def authenticate
    if valid_password?(@params['password']) && @request.post?
      set_cookie :_dir_server_session, $session_token
      redirect '/files'
    end
  end

  def valid_password?(password)
    $password_hash == Digest::SHA2.hexdigest(password + $session_token)
  end
end