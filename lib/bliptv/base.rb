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
  
  #
  # This is the class that should be instantiated for basic
  # communication with the Blip.tv API
  #
  class Base
    
    def initialize
    end
    
    # Implements the Blip.tv REST Upload API
    #
    # <tt>new_attributes</tt> hash should contain next required keys:
    # * <tt>title:</tt> The video title;
    # * <tt>file:</tt> The video file;
    #
    # and optionally:
    # * <tt>thumbnail:</tt> A thumbnail file;
    # * <tt>nsfw:</tt> true if explicit, false otherwise. Defaults to false;
    # * <tt>description:</tt> A description of the video
    # * <tt>username:</tt> Username
    # * <tt>password:</tt> Password
    # * <tt>keywords:</tt> A comma-separated string of keywords # TODO this should be nice and also accept Arrays
    # * <tt>categories:</tt> A Hash of categories
    # * <tt>license:</tt> A license for the video
    # * <tt>interactive_post:</tt> Specify whether or not a post is interactive. More here[http://wiki.blip.tv/index.php/API_2.0:_Post_Interactivity]
    #
    # Example:
    #
    #  bliptv.upload_video(:title => 'Check out this guy getting kicked in the nuts!', :file => File.open('/movies/nuts.mov'))
    #
    # Returns BlipTV::Video instance. 
    #
    def upload_video(new_attributes={})
      BlipTV::ApiSpec.check_attributes('videos.upload', new_attributes)
      
      request = BlipTV::Request.new(:post, 'videos.upload')
      request.run do |p|
        for param, value in new_attributes
          p.send("#{param}=", value)
        end
      end
      BlipTV::Video.new(request.response['video'])
    end
  
  end
end