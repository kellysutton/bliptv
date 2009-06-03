require 'net/http'
require 'uri'

module BlipTV
  
  # Raised when pinging Blip.tv for video information results in an error
  class VideoResponseError < BlipTVError #:nodoc:
    def initialize(message)
      super message
    end
  end
  
  # This class wraps Blip.tv's video's information.
  class Video
  
    attr_accessor :id,
                  :title,
                  :description,
                  :guid,
                  :deleted,
                  :view_count,
                  :tags,
                  :links,
                  :author,
                  :update_time,
                  :explicit,
                  :notes,
                  :license
                  
    def initialize(blip_id) #:nodoc:
      update_attributes_from_id(blip_id)
    end
    
    def update_attributes_from_id(blip_id)
      @id = blip_id
      
      a = get_attributes
      @title            = a['title']
      @description      = a['description']
      @guid             = a['guid']
      @deleted          = a['deleted']
      @view_count       = a['views']
      @tags             = a['tags']
      #@url              = a['url']
      @links            = a['links']
      @thumbnail_url    = a['thumbnail_url']
      @author           = a['created_by']['login']
      #@length_seconds   = a['length_seconds'].to_i
      #@comment_count    = a['comment_count'].to_i
      @update_time      = a['timestamp'] ? Time.at(a['update_time'].to_i) : nil
      @permissions      = a['permissions'] ? a['permissions'] : nil
      @explicit         = a['explicit']
      @license          = a['license']
      @notes            = a['notes']
      #@comments         = a['comment_list'].values.flatten.collect do |comment| 
      #                      BlipTV::Comment.new(comment)
      #                    end if a['comment_list']
    end
    
    #
    # fire off a HTTP GET response to Blip.tv
    #
    # In the future, this should probably be rolled into the 
    # BlipTV::Request class, so that all exception raising and 
    # network communication exists in instances of that class.
    #
    def get_attributes                                                         
      url = URI.parse('http://www.blip.tv/')   
      res = Net::HTTP.start(url.host, url.port) {|http|      
       http.get("http://www.blip.tv/file/#{@id.to_s}?skin=api")
      }                                                                                
      
      hash = Hash.from_xml(res.body)
      
      if hash["response"]["status"] != "OK"
        raise VideoResponseError.new(hash["response"]["notice"])
      end
      
      if hash["response"]["payload"]["asset"].is_a?(Array) 
       return hash["response"]["payload"]["asset"][0] # there may be several assets. In that case, read the first one
     else
       return hash["response"]["payload"]["asset"]
     end
    end
    
    #
    # Refresh the current video object. Useful to check up on encoding progress,
    # etc.
    #
    def refresh
      # TODO fill out this method
    end
    
    # Returns HTML code for video embedding.
    def embed_code(options={})
      
    end
  
  end
end