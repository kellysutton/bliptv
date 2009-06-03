require 'net/http'
require 'uri'



module BlipTV

  BLIP_TV_ID_EXPR = /\d{3,12}/
  
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
                  :license,
                  :embed_url,
                  :embed_code
                  
    def initialize(blip_id) #:nodoc:
      blip_id = blip_id.to_s if blip_id.class == Fixnum
      
      if blip_id.class == String && blip_id.match(BLIP_TV_ID_EXPR)
        update_attributes_from_id(blip_id)
      elsif blip_id.class == Hash
        update_attributes_from_hash(blip_id)
      end
    end
    
    def update_attributes_from_id(blip_id)
      @id = blip_id
      
      a = get_attributes
      update_attributes_from_hash(a)
    end
    
    def update_attributes_from_hash(a)
      @title            = a['title']
      @description      = a['description']
      @guid             = a['guid']
      @deleted          = a['deleted']
      @view_count       = a['views']
      if a['tags']
        @tags             = a['tags']['string'] ? a['tags']['string'].join(", ") : "" # TODO find a test that tests the tags
      end
      @links            = a['links']
      @thumbnail_url    = a['thumbnail_url']
      @author           = a['created_by']['login'] if a['created_by']
      @update_time      = a['timestamp'] ? Time.at(a['update_time'].to_i) : nil
      @explicit         = a['explicit']
      @license          = a['license']
      @notes            = a['notes']
      @embed_url        = a['embed_url']
      @embed_code       = a['embed_code']
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
      update_attributes_from_id(@id)
    end
  end
end