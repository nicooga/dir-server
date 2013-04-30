require_relative 'controller_base.rb'

class Index < ControllerBase
  def app
    filter :check_logged
    @files = Dir.entries($dir).map do |f|
      File.open("#{$dir}/#{f}")
    end
    render :index
  end
end