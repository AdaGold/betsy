class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

<<<<<<< HEAD

  def render_404
    raise ActionController::RoutingError.new('Not Found')
  end

=======
<<<<<<< HEAD
  def render_404
    raise ActionController::RoutingError.new('Not Found')
  end
=======
>>>>>>> bedd350556d7491e59030d11bf3d25300e2d80d9
>>>>>>> mm/item_model_and_controller_methods_and_tests

end
