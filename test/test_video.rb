require 'lib/bliptv'


NO_TAGS = "\n\t\t\n\t"

class TC_VideoTest < Test::Unit::TestCase
  def setup
  end
  
  def teardown
  end
  
  def test_video_initialize_with_int_and_string
    video1 = BlipTV::Video.new(2193230)
    video2 = BlipTV::Video.new("2193230")
    
    a = [video1, video2]
    
    a.each do |video|
      assert_not_equal    nil, video
      assert_instance_of  BlipTV::Video, video

      
      assert_equal "Super Mario Galaxy 2", video.title
      
      h = { "mode" => "escaped", "type" => "text/html" }
      assert_equal h, video.description
      
      assert_equal "D2215402-5017-11DE-9B2F-C1BCBB520399", video.guid           
      assert_equal "false", video.deleted        
      assert_equal nil, video.view_count # because we don't have the user login info
      assert_equal NO_TAGS, video.tags
      
      links = {"link"=>
        [{"href"=>"http://blip.tv/file/2193230",
          "rel"=>"alternate",
          "type"=>"text/html"},
         {"href"=>"http://blip.tv/file/2193230/?skin=api",
          "rel"=>"alternate",
          "type"=>"text/xml"},
         {"href"=>"http://blip.tv/file/post/2193230/",
          "rel"=>"service.edit",
          "type"=>"text/html"},
         {"href"=>"http://blip.tv/rss/2204077",
          "rel"=>"alternate",
          "type"=>"application/rss+xml"},
         {"href"=>"http://blip.tv/file/2193230/?skin=atom",
          "rel"=>"alternate",
          "type"=>"application/atom+xml"},
         {"href"=>"http://blip.tv/file/post/2193230/?skin=api",
          "rel"=>"service.edit",
          "type"=>"text/xml"}]}
      
      assert_equal links, video.links          
      assert_equal "kotaku", video.author         
      assert_equal "Thu Jan 01 01:00:00 +0100 1970", video.update_time.to_s # not sure why this is the epoch
      assert_equal "false", video.explicit       
      
      license = {"name"=>"No license (All rights reserved)"}
      assert_equal license, video.license
      
      notes = {"mode"=>"escaped", "type"=>"text/html"}
      assert_equal notes, video.notes          
    end
      
  end
  
end