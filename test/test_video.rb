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
      
      assert_equal "http://blip.tv/play/g4Q9gYbEEY35ZA", video.embed_url
      assert_equal "<embed src=\"http://blip.tv/play/g4Q9gYbEEY35ZA\" type=\"application/x-shockwave-flash\" width=\"854\" height=\"510\" allowscriptaccess=\"always\" allowfullscreen=\"true\"></embed>", video.embed_code
    end
  end
  
  def test_video_with_more_data
    video = BlipTV::Video.new(2141730)
    
    assert_equal "", video.title         
    assert_equal "", video.description   
    assert_equal "", video.guid          
    assert_equal "", video.deleted       
    assert_equal "", video.view_count    
    assert_equal "", video.tags          
    assert_equal "", video.links         
    assert_equal "", video.thumbnail_url 
    assert_equal "", video.author        
    assert_equal "", video.update_time   
    assert_equal "", video.permissions   
    assert_equal "", video.explicit      
    assert_equal "", video.license       
    assert_equal "", video.notes         
    assert_equal "", video.embed_url     
    assert_equal "", video.embed_code
  end
end