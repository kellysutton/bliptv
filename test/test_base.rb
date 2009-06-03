require 'lib/bliptv'

class TC_BaseTest < Test::Unit::TestCase
  def setup
    @base = BlipTV::Base.new
  end
  
  def teardown
  end
  
  def test_find_all_videos_by_user
    
    videos = @base.find_all_videos_by_user("onemonthhere")
    
    assert_not_equal nil, videos
    assert_instance_of Array, videos
    assert videos.size >= 12 # at the time of the writing of the test
    
    videos.each do |video|
      assert_equal "onemonthhere", video.author
      assert_equal "false", video.explicit # I know for a fact that all videos are not explicit
    end
  end
  
  def test_search_videos
    videos = @base.search_videos("cool")
    
    assert_not_equal nil, videos # unless Blip.tv is having a bad day :(
    assert_instance_of Array, videos
    assert videos.size > 10 # assumption
    
    videos.each do |video|
      assert_not_equal "", video.title # all videos must have a title
    end
  end
end