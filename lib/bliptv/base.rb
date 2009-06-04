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
      
      new_attributes = {
        :post => "1",
        :item_type => "file",
        :skin => "xmlhttprequest",
        :file_role => "Web"
      }.merge(new_attributes) # blip.tv requires the "post" param to be set to 1
      
      request = BlipTV::Request.new(:post, 'videos.upload')
      request.run do |p|
        for param, value in new_attributes
          p.send("#{param}=", value)
        end
      end

      BlipTV::Video.new(request.response['post_url'].to_s)
    end
    
    
    # Looks up all videos on Blip.tv with a given <tt>username</tt>
    #
    # Options hash could contain next values:
    # * <tt>page</tt>: The "page number" of results to retrieve (e.g. 1, 2, 3);
    # * <tt>per_page</tt>: The number of results to retrieve per page (maximum 100). If not specified, the default value equals 20.
    #
    # Example:
    #
    #  bliptv.find_all_videos_by_user("username")
    #
    # Returns array of BlipTV::Video objects.
    #
    def find_all_videos_by_user(username, options={})
      url, path = "#{username}.blip.tv", "/posts/?skin=api"
      request = Net::HTTP.get(url, path)
      hash = Hash.from_xml(request)
      hash == nil ? [] : parse_videos_list(hash)
    end
  
  
    # Searches through and returns videos based on the <tt>search_string</tt>.
    #
    # This method is a direct call of Blip.tv's search method. You get what you get. No guarantees are made.
    #
    # Example:
    #
    #   bliptv.search_videos("cool stuff")
    #
    # Returns an array of BlipTV::Video objects
    #
    def search_videos(search_string)
      request = Net::HTTP.get(URI.parse("http://www.blip.tv/search/?search=#{search_string}&skin=api"))
      hash = Hash.from_xml(request)
      parse_videos_list(hash)
    end
    
    private
  
    def parse_videos_list(hash)
      list = []
      begin
        hash["response"]["payload"]["asset"].each do |entry| 
          list << Video.new(entry)
        end
      rescue NoMethodError
        list = []
      end
      list
    end
  end
end