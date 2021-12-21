module ApplicationHelper

  def nav_controller_class(controller)
    if params[:controller] == controller
      "inline-block py-2 px-4 text-white no-underline"
    else
      "inline-block text-gray-400 no-underline hover:text-gray-200 hover:text-underline py-2 px-4"
    end
  end

end
