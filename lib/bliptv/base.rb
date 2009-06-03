module BlipTV
  # Generic BlipTV exception class.
  class BlipTVError < StandardError #:nodoc:
  end

  # Raised when username and password has not been set.
  class AuthenticationRequiredError < BlipTVError #:nodoc:
    def message
      "Method that you're trying to execute requires username and password."
    end
  end

  # Raised when calling not yet implemented API methods.
  class NotImplementedError < BlipTVError #:nodoc:
    def message
      'This method is not yet implemented.'
    end
  end
  
end