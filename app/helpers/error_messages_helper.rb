module ErrorMessagesHelper

  def generate_error_title
    if controller_name == 'error_messages'
      if action_name == 'error_422'
        return "The change you wanted was rejected (422)"
      elsif action_name == 'error_404'
        return "The page you were looking for doesn't exist (404)"
      else
        return "We're sorry, but something went wrong (500)"
      end
    end
  end

end
