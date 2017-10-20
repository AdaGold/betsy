class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

<<<<<<< HEAD
  def render_404
    raise ActionController::RoutingError.new('Not Found')
  end
=======
>>>>>>> eea969ce2b5fd8ecbe2d7b10dad27aa46d67156c

end
