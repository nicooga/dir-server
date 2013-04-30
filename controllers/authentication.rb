require_relative 'controller_base.rb'

class Authentication < ControllerBase
  def new
    render :auth
  end

  def create
    if valid_password?(@params['password']) && @params['password']
      set_cookie :_dir_server_session, $session_token
      redirect '/files'
    end
  end

  def delete
    delete_cookie(:_dir_server_session)
    redirect '/files'
  end

  private

  def valid_password?(password)
    $password_hash == Digest::SHA2.hexdigest(password + $session_token)
  end
end