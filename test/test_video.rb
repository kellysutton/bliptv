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
      assert_equal "", video.tags
      
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
    
    assert_equal "Field Recon - One Month Here - Episode 9", video.title         
    assert_equal "I spend most of today out in the field, scoping out challenge locations. Berghain looks eerie and deserted. It's likely the exact opposite at night. I need some swimming trunks...<br /><br /> Tweets read today from @<a href=\"http://twitter.com/iMuesli\">iMuesli</a> , @<a href=\"http://twitter.com/andrewseely\">andrewseely</a> , @<a href=\"http://twitter.com/JDFirst\">JDFirst</a> , @<a href=\"http://twitter.com/grasp183\">grasp183</a> and @<a href=\"http://twitter.com/mxchickmagnet86\">mxchickmagnet86</a><br /><br /> Thanks for watching!", video.description   
    assert_equal "DB14423E-460F-11DE-B85A-FF0EAE6B9387", video.guid          
    assert_equal "false", video.deleted       
    assert_equal nil, video.view_count    
    assert_equal "bergain, badeschiff, kelly sutton, berlin, germany, kreuzberg", video.tags          
    
    links = {"link"=>
      [{"href"=>"http://blip.tv/file/2141730",
        "rel"=>"alternate",
        "type"=>"text/html"},
       {"href"=>"http://blip.tv/file/2141730/?skin=api",
        "rel"=>"alternate",
        "type"=>"text/xml"},
       {"href"=>"http://blip.tv/file/post/2141730/",
        "rel"=>"service.edit",
        "type"=>"text/html"},
       {"href"=>"http://blip.tv/rss/2152384",
        "rel"=>"alternate",
        "type"=>"application/rss+xml"},
       {"href"=>"http://blip.tv/file/2141730/?skin=atom",
        "rel"=>"alternate",
        "type"=>"application/atom+xml"},
       {"href"=>"http://blip.tv/file/post/2141730/?skin=api",
        "rel"=>"service.edit",
        "type"=>"text/xml"}]}
    assert_equal links, video.links         
    assert_equal "onemonthhere", video.author        
    assert_equal 0, video.update_time.to_i
    assert_equal "false", video.explicit
    
    licensce = {"name"=>"Creative Commons Attribution 3.0",
     "link"=>
      {"href"=>"http://creativecommons.org/licenses/by/3.0/", "type"=>"text/html"}}
    assert_equal licensce, video.license  
    
    notes = {"mode"=>"escaped", "type"=>"text/html"}     
    assert_equal notes, video.notes         
    assert_equal "http://blip.tv/play/AYGDsCSV5jE", video.embed_url     
    assert_equal "<embed src=\"http://blip.tv/play/AYGDsCSV5jE\" type=\"application/x-shockwave-flash\" width=\"640\" height=\"510\" allowscriptaccess=\"always\" allowfullscreen=\"true\"></embed>", video.embed_code
  end
end