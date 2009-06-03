module BlipTV
  # This class wraps Blip.tv's video's information.
  class Video
  
    attr_accessor :id, 
                  :url, 
                  :title, 
                  :description, 
                  :tags, 
                  :thumbnail_url,
                  :author, 
                  :length_seconds, 
                  :view_count, 
                  :upload_time,
                  :comment_count, 
                  :update_time, 
                  :permissions, 
                  :comment_list
  
    def initialize(attributes={}) #:nodoc:
      a = attributes
      @id               = a['id']
      @title            = a['title']
      @description      = a['description']
      @tags             = a['tags']
      @url              = a['url']
      @thumbnail_url    = a['thumbnail_url']
      @author           = a['author']
      @length_seconds   = a['length_seconds'].to_i
      @view_count       = a['view_count'].to_i
      @comment_count    = a['comment_count'].to_i
      @update_time      = a['update_time'] ? Time.at(a['update_time'].to_i) : nil
      @permissions      = a['permissions'] ? a['permissions'] : nil
      #@comments         = a['comment_list'].values.flatten.collect do |comment| 
      #                      BlipTV::Comment.new(comment)
      #                    end if a['comment_list']
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